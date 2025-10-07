import 'dart:io';

import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:pms_extends/urlconfigs/api_url_config.dart';
import 'package:http/io_client.dart';

class GraphqlClientProvider {
  Client? _client;
  Client get client {
    if (_client == null) {
      throw Exception('GraphqlClientProvider not initialized');
    }
    return _client!;
  }
  
  void setClient(ApiUrlConfig apiUrlConfig, {String? token}) {
    final ioClient = apiUrlConfig.isSecurityContextAvailable
        ? IOClient(HttpClient(context: apiUrlConfig.securityContext))
        : null;
    final link = HttpLink(
      apiUrlConfig.apiUrl.toString(),
      defaultHeaders: {if (token != null) 'Authorization': 'Bearer $token'},
      httpClient: ioClient,
    );
    _client = Client(link: link);
  }
}
