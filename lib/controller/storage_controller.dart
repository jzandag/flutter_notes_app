import 'package:flutter/cupertino.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageControllerProvider = Provider<StorageController>(
  (ref) => StorageController(ref),
);

class StorageController {
  final Ref _ref;

  StorageController(this._ref);

  void addNoteImage(BuildContext context) async {
    dynamic file = await _ref.watch(storageServiceProvider).pickFile();
    if (file == null) {
      Constants.showSnackBar(context, 'Error in picking image');
      return;
    }
    _ref
        .watch(storageRepositoryProvider)
        .saveFile(file['path'], file['fileName']);
  }

  void chooseImage(BuildContext context) async {
    dynamic file = await _ref.watch(storageServiceProvider).pickFile();
    if (file == null) {
      Constants.showSnackBar(context, 'Error in picking image');
      return;
    }
    _ref.read(noteChangeNotifier.notifier).addImage(file);
  }
}
