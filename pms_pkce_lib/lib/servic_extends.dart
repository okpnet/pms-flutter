import 'package:get_it/get_it.dart';
import 'providers/pms_provider.dart';

extension ServicExtends on GetIt{
  GetIt addPmsService(String pkceUrljsonSource){
    final getit=GetIt.instance;
    getit.registerSingleton<AuthStateModel>(AuthStateModel(pkce: PKCEModel.generate()));
    getit.registerSingleton<PkceAuthenticatorProvider>(PkceAuthenticatorProvider.create(pkceUrljsonSource, getit<AuthStateModel>()));
    return GetIt.instance;
  }
}
