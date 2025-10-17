import 'package:fetch_token/file_helper.dart';
import 'package:pms_extends/urlconfigs/api_url_config.dart';

class ParameterModel  {
  String? baseUrl;
  String? clientId;
  String? token;
  String? certFilePath;

  Future<ApiUrlConfig> convrt() async {
    return ApiUrlConfig(
      baseUrl: baseUrl ?? "",
      apiPath: clientId ?? "",
      certData: certFilePath==null || certFilePath!.isEmpty ? null  : await FileHelper.readBuffer(certFilePath!),
    );
  }
}