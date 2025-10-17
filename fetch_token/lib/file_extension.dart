import 'package:file_picker/file_picker.dart';

class FileExtension {

  static Future<FilePickerResult?> pickKmlFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['kml','xml'],
    );
    result.paths.first
    return result;
  }


  static String getFileExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex != -1 && dotIndex < fileName.length - 1) {
      return fileName.substring(dotIndex + 1);
    }
    return '';
  }
}