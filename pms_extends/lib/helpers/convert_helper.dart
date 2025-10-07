import 'dart:convert';
import 'dart:typed_data';

class ConvertHelper {
  static ByteData? convertByteData(dynamic? arg) {
    if (arg == null) return null;
    final bytes = base64Decode(arg as String);
    return ByteData.sublistView(bytes);
  }

  static String? base64FromByteData(ByteData? arg) {
    if (arg == null) return null;
    final certList = arg.buffer.asUint8List();
    return certList.isEmpty ? null : base64Encode(certList);
  }

  static Map<String, dynamic> jsonSafeDecode(String? buffer) {
    if (buffer == null || buffer.isEmpty) return {};
    try {
      final decoded = jsonDecode(buffer);
      return decoded is Map<String, dynamic> ? decoded : {};
    } catch (e) {
      // JSONパース失敗
      return {};
    }
  }
}
