import 'pkce_model.dart';
import 'token_model.dart';

class AuthStateModel {
  PKCEModel pkce;
  TokenModel? token;

  AuthStateModel({required this.pkce, this.token});

  bool get isAuthenticated => token != null && !token!.isExpired;
}