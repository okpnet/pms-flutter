import 'dart:io';
import 'dart:async';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:pms_extends/urlconfigs/api_url_config.dart';
import 'package:http/io_client.dart';
import 'events/graphql_event.dart';

class GraphqlClientProvider {
  Client? _client;
  final StreamController<Graphqlevent> _graphqlEventStream =
      StreamController<Graphqlevent>();

  Stream<Graphqlevent> get graphqlEventStream => _graphqlEventStream.stream;
  StreamSink<Graphqlevent> get graphqlEventSink => _graphqlEventStream.sink;

  Client get client {
    if (_client == null) {
      throw Exception('GraphqlClientProvider not initialized');
    }
    return _client!;
  }

  Client? getClient(ApiUrlConfig apiUrlConfig, { String? token }) {
    final ioClient = apiUrlConfig.isSecurityContextAvailable
        ? IOClient(HttpClient(context: apiUrlConfig.securityContext))
        : null;
    final link = HttpLink(
      apiUrlConfig.apiUrl.toString(),
      defaultHeaders: {if (token != null) 'Authorization': 'Bearer $token'},
      httpClient: ioClient,
    );
    return Client(link: link);
  }
}
