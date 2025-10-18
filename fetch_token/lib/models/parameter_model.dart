import 'package:fetch_token/file_helper.dart';
import 'package:pms_pkce_lib/providers/pms_provider.dart';

class ParameterModel  {
  String? baseUrl;
  String? clientId;
  String? token;
  String? certFilePath;
  String? redirectPath;
  PkceConfig? _pkceConfig;

  bool get isValid{
    return baseUrl!=null && baseUrl!.isNotEmpty
        && clientId!=null && clientId!.isNotEmpty;
  }

  Future<ApiUrlConfig> convrt() async {
    return ApiUrlConfig(
      baseUrl: baseUrl ?? "",
      apiPath: clientId ?? "",
      certData: certFilePath==null || certFilePath!.isEmpty ? null  : await FileHelper.readBuffer(certFilePath!),
    );
  }

  Future<PkceUrlConfig> convertToPkceUrlConfig() async {
    _pkceConfig=_pkceConfig?? PkceConfig(clientId: clientId!);
    return PkceUrlConfig(
      baseUrl: baseUrl ?? "",
      apiPath: clientId ?? "",
      redirectPath: redirectPath ?? "",
      pkceConfig: _pkceConfig!,
      certData: certFilePath==null || certFilePath!.isEmpty ? null  : await FileHelper.readBuffer(certFilePath!),
    );
  }
}