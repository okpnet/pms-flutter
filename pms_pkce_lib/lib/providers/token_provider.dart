import '../models/token_model.dart';

abstract class TokenProvider {
  /// トークンを取得する（認証済みでなければ認証を開始）
  Future<TokenModel> getToken();

  /// トークンが有効かどうか
  bool get isTokenValid;

  /// トークンを明示的に更新（refresh_tokenなど）
  Future<TokenModel?> refreshToken();
}