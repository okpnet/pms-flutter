import 'auth_event.dart';

class AuthFailEvent extends AuthEvent {
  final String description;
  final String errorCode;
  AuthFailEvent(super.state,{required this.errorCode,this.description=""});
}