import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' show Response;
import 'package:http/io_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pms_extends/helpers/convert_helper.dart';
import '../extends/auth_event_factory.dart';
import 'pms_provider.dart';

/// PKCE認証プロバイダー
class PkceAuthenticatorProvider {
  /// URL設定
  final PkceUrlConfig urlConfig;
  /// 認証状態モデル
  final AuthStateModel state;
  /// 認証イベントストリームコントローラー
  final StreamController<AuthEvent> _authEventStream =
      StreamController<AuthEvent>();
  /// HTTP POSTプロバイダー
  final PostProvider postProvider;
  /// 認証イベントストリーム
  Stream<AuthEvent> get stream => _authEventStream.stream;
  /// 認証イベントストリームシンク
  StreamSink<AuthEvent> get streamSink => _authEventStream;

  PkceAuthenticatorProvider({
    required this.urlConfig,
    required this.state,
    required this.postProvider,
  });
/// PKCE認証プロバイダー生成
  factory PkceAuthenticatorProvider.create(PkceUrlConfig urlConfig,{ AuthStateModel? state}) {
    return PkceAuthenticatorProvider(
      urlConfig: urlConfig,
      state: state ?? AuthStateModel(pkce: PKCEModel.generate()),
      postProvider: HttpPostProvider(),
    );
  }
/// PKCE認証プロバイダー生成（JSON文字列から）
  factory PkceAuthenticatorProvider.createFromJson(
    String pkceUrljsonSource,
    {AuthStateModel? state}
  ) {
    var configMap = PkceUrlConfig.fromJsonString(pkceUrljsonSource);
    return PkceAuthenticatorProvider(
      urlConfig: configMap,
      state: state?? AuthStateModel(pkce: PKCEModel.generate()),
      postProvider: HttpPostProvider(),
    );
  }

  /// 認証開始（ログイン）
  Future<void> login() async {
    // 認証開始イベント（ログアウトにも使用可能）
    _authEventStream.add(AuthEventFactory.start(state));
    final pkce = state.pkce;

    // 認可サーバーの発見とクライアント構築
    final securityContext = urlConfig.securityContext;
    final ioClient = urlConfig.isSecurityContextAvailable
        ? IOClient(HttpClient(context: securityContext))
        : null;
    final issuer = await Issuer.discover(
      urlConfig.authUrl,
      httpClient: ioClient,
    );
    final client = Client(issuer, urlConfig.pkceConfig.clientId);

    // ブラウザ起動関数
    Future<void> launch(String url) async {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    // 認証フロー開始
    final authenticator = Authenticator(
      client,
      scopes: urlConfig.pkceConfig.scopes,
      redirectUri: urlConfig.redirectUrl,
      port: urlConfig.redirectUrl.port,
      urlLancher: launch,
      prompt: 'login',
      additionalParameters: {
        'code_challenge': pkce.challenge,
        'code_challenge_method': urlConfig.pkceConfig.challengeMethod,
      },
    );

    final credential = await authenticator.authorize();
    final tokenResponse = await credential.getTokenResponse();
    final addBodys = {
      "grant_type": "authorization_code",
      "code": tokenResponse['code'],
      "redirect_uri": urlConfig.redirectUrl.toString(),
      "client_id": urlConfig.pkceConfig.clientId,
      "code_verifier": pkce.verifier,
    };

    final response = await postProvider.post(
      url: urlConfig.tokenUrl,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: Uri(queryParameters: addBodys).query,
      context: urlConfig.securityContext,
    );

    _responseObservable(response);
  }

  Future<void> refreshTokenIfNeeded() async {
    if (state.token?.isExpired ?? true) {
      await _refreshToken();
    }
  }

  Future<void> forcceRefreshToken() async {
    await _refreshToken();
  }

  Future<void> logout() async {
    if (state.token == null || state.token?.refreshToken == null) return;

    final addBodys = {
      "refresh_token": state.token?.refreshToken,
      "client_id": urlConfig.pkceConfig.clientId,
      //"client_secret": "",//PKCEでログインしているので不要
    };

    final response = await postProvider.post(
      url: urlConfig.logoutUrl,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: Uri(queryParameters: addBodys).query,
      context: urlConfig.securityContext,
    );

    _responseObservable(response);
  }

  Future<void> _refreshToken() async {
    final currentToken = state.token;
    if (currentToken == null || currentToken.refreshToken == null) return;

    final body = {
      "grant_type": "refresh_token",
      "refresh_token": currentToken.refreshToken!,
      "client_id": urlConfig.pkceConfig.clientId,
    };

    final response = await postProvider.post(
      url: urlConfig.tokenUrl,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: Uri(queryParameters: body).query,
      context: urlConfig.securityContext,
    );

    _responseObservable(response);
  }

  void _responseObservable(Response response) {
    final responseBody = ConvertHelper.jsonSafeDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // トークンモデル構築
        final token = TokenModel(
          accessToken: responseBody['access_token'],
          refreshToken: responseBody['refresh_token'],
          idToken: responseBody['id_token'],
          tokenype: responseBody['token_type'],
          claims: {}, //キーがhttps://hasura.io/jwt/claimsこうなので取得方法を検討
          expiresAt: DateTime.now().add(
            Duration(seconds: responseBody['expires_in'] as int),
          ),
        );

        // 認証完了イベント
        _authEventStream.add(AuthEventFactory.complete(token, state));
        break;
      case 204:
        //ログアウト
        state.token = null;
        _authEventStream.add(AuthEventFactory.logout(state));
        break;
      case 400:
        //認証失敗
        _authEventStream.add(
          AuthFailEvent(
            state,
            errorCode: responseBody['error'],
            description: responseBody['error_description'],
          ),
        );
        break;
    }
  }
}
