import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PKCEModel{
  final String verifier;
  final String challenge;

  PKCEModel._(this.verifier, this.challenge);

  static PKCEModel generate() {
    String generateCodeVerifier() {
      final random = Random.secure();
      final values = List<int>.generate(32, (i) => random.nextInt(256));
      return base64UrlEncode(values).replaceAll('=', '');
    }

    String generateCodeChallenge(String verifier) {
      final bytes = utf8.encode(verifier);
      final digest = sha256.convert(bytes);
      return base64UrlEncode(digest.bytes).replaceAll('=', '');
    }

    final v = generateCodeVerifier();
    final c = generateCodeChallenge(v);
    return PKCEModel._(v, c);
  }
}