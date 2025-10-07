import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

abstract class BaseUrlConfig {
  String get baseUrl;
  Uri get apiUrl;
  SecurityContext? get securityContext;

  ByteData? get certData;

  Uri getUri(List<String> paths) {
    final base = Uri.parse(baseUrl);

    final normalizedPaths = paths
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .map((p) => p.replaceAll(RegExp(r'^/+|/+$'), ''))
        .toList();

    final normalizedPath = [
      ...base.pathSegments.where((p) => p.isNotEmpty),
      ...normalizedPaths,
    ].join('/');

    final url = Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
      path: normalizedPath,
    );
    print(url.toString());
    return url;
  }

  /// シリアライズ用
  Map<String, dynamic> toMap() {
    final certList = certData?.buffer.asUint8List();
    return {
      'baseUrl': baseUrl,
      'certData': certList != null ? base64Encode(certList) : null,
    };
  }
}
