import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FileExtension {
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
  static Future<ByteData?> readFileToBytes(List<String> allowedExtensions) async {
    final result = await pickKmlFile(allowedExtensions);
    if(result == null || result.count!=1)return ByteData(0);
    final bytes= File(result.paths.first!).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}