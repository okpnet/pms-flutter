import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

/// A helper class for file operations such as picking files and reading file contents.
class FileHelper {
  /// Opens a file picker dialog to select a file with specified allowed extensions.
  static Future<FilePickerResult?> pickKmlFile(List<String> allowedExtensions,{bool allowMultiple = false}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: allowMultiple,
    );
    return result;
  }
  /// Reads a file with specified allowed extensions and returns its content as ByteData.
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