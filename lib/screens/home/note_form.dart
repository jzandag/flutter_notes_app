import 'package:flutter/material.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:flutter_notes_app/screens/home/note_color.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/note.dart';

class NoteForm extends HookConsumerWidget {
  NoteForm({Key? key}) : super(key: key);
  final String dateNow = DateFormat.yMd().add_jm().format(DateTime.now());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProvider = ref.watch(noteChangeNotifier);
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();

    void _handleNoteSave() {
      final noteRepository = ref.watch(noteRepositoryProvider);
      noteRepository.saveNote(
        Note(
          title: _titleController.text,
          note: _mainController.text,
          createDate: dateNow,
          colorId: noteProvider.colorId,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Note saved!"),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Constants.notesColorList[noteProvider.colorId],
      appBar: AppBar(
        backgroundColor: Constants.notesColorList[noteProvider.colorId],
        title: const Text("New Note"),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteColor(
              currentColor: noteProvider.colorId,
            ),
            const TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Title...'),
              style: Constants.titleStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(dateNow),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your note...',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          print(_mainController.text);
          _handleNoteSave();
        },
        tooltip: 'Add Note',
        icon: const Icon(Icons.edit),
        label: const Text('Save Note'),
      ),
    );
  }
}
