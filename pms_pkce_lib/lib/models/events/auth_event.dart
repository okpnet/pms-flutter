import '../auth_state_model.dart';

abstract class AuthEvent {
  AuthEvent(AuthStateModel state);
}