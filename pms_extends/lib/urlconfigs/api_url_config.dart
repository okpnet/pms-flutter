import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import '../helpers/convert_helper.dart';
import 'base_url_config.dart';


class ApiUrlConfig extends BaseUrlConfig {
  @override final String baseUrl;
  final String apiPath;
  @override final ByteData? certData;

  late final SecurityContext? _context;

  bool get isSecurityContextAvailable => certData?.lengthInBytes != null && certData!.lengthInBytes > 0;

  ApiUrlConfig({
    required this.baseUrl,
    required this.apiPath,
    this.certData,
  }) {
    if(certData == null || certData!.lengthInBytes > 0)return;
    final context = SecurityContext(withTrustedRoots: true);
    context.setTrustedCertificatesBytes(certData!.buffer.asUint8List());
    _context = context;
  }

  @override Uri get apiUrl => Uri.parse(apiPath);
  @override SecurityContext? get securityContext => _context;
  
  @override
  Map<String, dynamic> toMap() =>{
      'baseUrl': baseUrl,
      'apiPath': apiPath,
      'certData': ConvertHelper.base64FromByteData(certData),
    };

  factory ApiUrlConfig.fromMap(Map<String, dynamic> map)=>ApiUrlConfig(
      baseUrl: map['baseUrl'] as String,
      apiPath: map['apiPath'] as String,
      certData: ConvertHelper.convertByteData(map['certData']),
    );
}