import '../auth_state_model.dart';
import 'auth_event.dart';


class AuthLogoutEvent extends AuthEvent {
  AuthLogoutEvent(AuthStateModel state):super(state){
    state.token=null;
  }
}