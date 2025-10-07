import '../models/pms_model.dart';
import '../models/events/pms_event.dart';

/// 認証イベントを生成するファクトリークラス。
/// 認証処理の各段階（開始、完了、有効期限切れ）に対応したイベントを生成する。
class AuthEventFactory {
  /// 認証開始イベントを生成する。
  /// [state] 現在の認証状態モデル
  static AuthEvent start(AuthStateModel state) => AuthStartEvent(state);

  /// 認証完了イベントを生成する。
  /// [token] 取得したトークン
  /// [state] 現在の認証状態モデル
  static AuthEvent complete(TokenModel token, AuthStateModel state) => AuthCompleteEvent(token, state);

  /// 認証有効期限切れイベントを生成する。
  /// [state] 現在の認証状態モデル
  static AuthEvent expired(AuthStateModel state) => AuthExpiredEvent(state);
  ///
  ///
  static AuthEvent logout(AuthStateModel state)=>AuthLogoutEvent(state);
}