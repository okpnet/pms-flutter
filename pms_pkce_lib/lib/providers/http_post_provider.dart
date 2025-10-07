import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'post_provider.dart';

class HttpPostProvider implements PostProvider {
  HttpPostProvider();

  @override
  Future<Response> post({
    required Uri url,
    required Map<String, String> headers,
    required String body,
    SecurityContext? context,
  }) async {

    Future<Response> securePost() async {
      final client = IOClient(HttpClient(context: context));
      final response = await client.post(
        url,
        headers: headers,
        body: body,
      );
      return response;
    }

    Future<Response> normalPost() async {
      final response = await http.post(
        url,
        headers: headers,
        body: body
      );
      return response;
    }
    return  context == null ? await normalPost() : await securePost();
  }
}