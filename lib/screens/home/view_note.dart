import 'package:flutter/material.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/note.dart';

class ViewNote extends HookConsumerWidget {
  final Note note;
  ViewNote({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int colorId = note.colorId ?? 0;

    TextEditingController _titleController =
        TextEditingController(text: note.title);
    TextEditingController _mainController =
        TextEditingController(text: note.note);

    void _handleNoteSave() {
      final noteRepository = ref.watch(noteRepositoryProvider);
      noteRepository.updateNote(
        Note(
          title: _titleController.text,
          note: _mainController.text,
          colorId: colorId,
          userId: note.userId,
          isPinned: false,
          uid: note.uid,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Note updated!"),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context);
    }

    void _handleDelete() {
      final noteRepository = ref.watch(noteRepositoryProvider);
      print('uid ${note.uid}');
      noteRepository.deleteNote(note.uid ?? '');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Delete success!"),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Constants.notesColorList[colorId],
      appBar: AppBar(
        backgroundColor: Constants.notesColorList[colorId],
        title: Text(note.title ?? 'Edit Note'),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () async {
              print('delete button, ' + (note.uid ?? ''));
              _handleDelete();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Title...'),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(note.createDate ?? ''),
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
        tooltip: 'Update Note',
        icon: const Icon(Icons.edit),
        label: const Text('Update Note'),
      ),
    );
  }
}
