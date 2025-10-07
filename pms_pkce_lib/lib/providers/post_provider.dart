import 'dart:io';

import 'package:http/http.dart';

abstract class PostProvider {
  Future<Response> post({
    required Uri url,
    required Map<String, String> headers,
    required String body,
    SecurityContext? context,
  });
}