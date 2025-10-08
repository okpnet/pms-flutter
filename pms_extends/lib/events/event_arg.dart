/// イベント引数の基本抽象クラス
abstract class EventArgBase {}

/// 汎用的な値を保持するイベント引数クラス
class EventArg<T> extends EventArgBase {
  /// 保持する値
  T? value;

  /// コンストラクタ
  EventArg({this.value});
}

/// Exception を保持するイベント引数クラス
class ExceptionEventArg extends EventArgBase {
  /// 保持する Exception
  Exception? exception;

  /// コンストラクタ
  ExceptionEventArg({this.exception});
}