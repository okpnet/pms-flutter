import 'dart:io';
import 'dart:typed_data';

class FileHelper {

  static Future<ByteData?> readBuffer(String path) async{
    try {
      final file=File(path);
      final contents=file.openRead();

      ByteData byteData=await contents.fold<BytesBuilder>(BytesBuilder(), (previous, element) {
        previous.add(element);
        return previous;
      }).then((value) => ByteData.view(value.toBytes().buffer));
      return byteData;
    } catch (e) {
      return null;
    }
  }
}