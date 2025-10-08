/// パラメータの基本抽象クラス
abstract class Parameter {
}

/// 値を保持するパラメータの抽象クラス
abstract class ValueParameter<T> extends Parameter {
  /// 保持する値
  T? value;

  /// コンストラクタ
  ValueParameter(this.value);
}

/// 値と結果を保持するパラメータクラス
class ResultParameter<T, R> extends ValueParameter<T> {
  /// 結果値
  R? result;

  /// コンストラクタ
  ResultParameter(super.value, this.result);
}

/// 結果（bool型）を持つパラメータクラス
class Result<R> extends ResultParameter<R, bool> {
  /// 結果が true かどうかを返す
  bool get isResult => result ?? false;

  /// コンストラクタ
  Result(super.value, super.result);
}

/// Exception を保持する結果パラメータクラス
class ResultException extends Result<Exception> {
  /// 保持している Exception を返す
  Exception? get exception => value;

  /// コンストラクタ
  ResultException(super.value, super.result);
}