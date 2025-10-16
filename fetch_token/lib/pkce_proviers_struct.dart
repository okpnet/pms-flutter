
import 'package:fetch_token/models/parameter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pms_pkce_lib/providers/pms_provider.dart';

class PkceProviersStruct {
  late final StateProvider<ParameterModel> parameterModelProvider;
  late final Provider<PkceUrlConfig> pkceUrlConfigProvider;
  late final Provider<PkceAuthenticatorProvider> pkceAuthenticatorProvider;
  late final StreamProvider<AuthEvent> pkceAuthEventStreamProvider;

  PkceProviersStruct(){//順序に注意
    parameterModelProvider = StateProvider<ParameterModel>((ref) {
      // 初期化済みの状態を返す（必要に応じて StateNotifier にしてもOK）
      return ParameterModel();
    });
    pkceUrlConfigProvider = Provider<PkceUrlConfig>((ref) {
      final param = ref.watch(parameterModelProvider);
      return PkceUrlConfig.fromParameter(param); // コンバート処理
    });
    pkceAuthenticatorProvider = Provider<PkceAuthenticatorProvider>((ref) {
      final config = ref.watch(pkceUrlConfigProvider);
      return PkceAuthenticatorProvider.create(config);
    });
    pkceAuthEventStreamProvider = StreamProvider.autoDispose<AuthEvent>((ref) {
      final authenticator = ref.watch(pkceAuthenticatorProvider);
      return authenticator.stream;
    });
  }
}
