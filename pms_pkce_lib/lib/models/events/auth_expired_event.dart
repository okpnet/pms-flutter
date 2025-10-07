import 'auth_event.dart';
import '../auth_state_model.dart';

class AuthExpiredEvent extends AuthEvent {
  AuthExpiredEvent(AuthStateModel state):super(state){
    state.token=null;
  }
}