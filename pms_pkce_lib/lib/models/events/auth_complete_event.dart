import 'auth_event.dart';
import '../pms_model.dart';

class AuthCompleteEvent extends AuthEvent {
  late final TokenModel tokenModel;
  AuthCompleteEvent(TokenModel token, AuthStateModel state) : super(state) {
    state.token = token;
    tokenModel=token;
  }
}