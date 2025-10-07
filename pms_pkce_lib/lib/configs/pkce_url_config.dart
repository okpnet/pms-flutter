import 'dart:io';
import 'dart:typed_data';
import 'package:pms_extends/helpers/convert_helper.dart';
import '../configs/pms_config.dart';

class PkceUrlConfig extends BaseUrlConfig {
  static const String _token='token';
  static const String _logout='logout';

  @override final String baseUrl;
  final String redirectPath;
  final String apiPath;
  final PkceConfig pkceConfig;
  @override final ByteData? certData;

  PkceUrlConfig({
    required this.baseUrl,
    required this.redirectPath,
    required this.apiPath,
    required this.pkceConfig,
    this.certData,
  });

  Uri get authUrl => Uri.parse(baseUrl);
  Uri get tokenUrl => getUri([apiPath,_token]);
  Uri get logoutUrl => getUri([apiPath,_logout]);
  Uri get redirectUrl => Uri.parse(redirectPath);
  @override Uri get apiUrl => Uri.parse(apiPath);
  @override SecurityContext? get securityContext{
    if(!isSecurityContextAvailable) return null;
    final context = SecurityContext(withTrustedRoots: true);
    context.setTrustedCertificatesBytes(certData!.buffer.asUint8List());
    return context;
  }
  bool get isSecurityContextAvailable => certData?.lengthInBytes != null && certData!.lengthInBytes > 0;

  @override
  Map<String, dynamic> toMap()=> {
      'baseUrl': baseUrl,
      'redirectPath': redirectPath,
      'apiPath': apiPath,
      'certData': ConvertHelper.base64FromByteData(certData),
      'pkceConfig':pkceConfig.toMap()
    };

  static PkceUrlConfig fromMap(Map<String, dynamic> map) =>PkceUrlConfig(
      baseUrl: map['baseUrl'] as String,
      redirectPath: map['redirectPath'] as String,
      apiPath: map['apiPath'] as String,
      certData: ConvertHelper.convertByteData(map['certData']),
      pkceConfig: PkceConfig.fromMap(map['pkceConfig'])
    );

  static PkceUrlConfig fromJsonString(String source){
    final map = ConvertHelper.jsonSafeDecode(source);
    return PkceUrlConfig.fromMap(map);
  }
}