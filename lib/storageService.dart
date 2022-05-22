import 'package:file_picker/file_picker.dart';

class StorageService {
  Future<Map?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result == null) {
      return null;
    }
    final path = result.files.single.path;
    final fileName = result.files.single.name;
    return {
      'path': path,
      'fileName': fileName,
    };
  }

  Future<void> putFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result == null) {
      return;
    }
  }
}
