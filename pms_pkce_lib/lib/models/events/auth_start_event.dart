import 'auth_event.dart';
import '../auth_state_model.dart';
import '../pkce_model.dart';

class AuthStartEvent extends AuthEvent {
  AuthStartEvent(AuthStateModel state) : super(state) {
    state.token = null;
    state.pkce = PKCEModel.generate();
  }
}