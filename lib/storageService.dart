import 'package:file_picker/file_picker.dart';

class StorageService {
  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result == null) {
      print('file uploaded');
      return null;
    }
    final path = result.files.single.path;
    final fileName = result.files.single.name;
    print(path);
    print(fileName);
  }
}
