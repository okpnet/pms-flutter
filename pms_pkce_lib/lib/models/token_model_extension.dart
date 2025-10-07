import 'dart:convert';
import 'package:pms_extends/helpers/convert_helper.dart';
import 'pms_model.dart';

extension TokenModelExtension on TokenModel{

  UserInfo extractUserInfo() {
    final payload = _decodeJwtPayload(idToken??'');

    return UserInfo(
      id: payload['sub'] ?? '',
      email: payload['email'] ?? '',
      firstName: payload['given_name'] ?? '',
      lastName: payload['family_name'] ?? '',
      username: payload['preferred_username'] ?? '',
    );
  }

  Map<String, dynamic> _decodeJwtPayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw FormatException('Invalid JWT format');
    }

    final payload = _normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(payload));
    return ConvertHelper.jsonSafeDecode(decoded);
  }

  String _normalize(String input) {
    final pad = input.length % 4;
    if (pad > 0) {
      input += '=' * (4 - pad);
    }
    return input;
  }
}