import 'package:flutter/material.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/note.dart';
import 'note_color.dart';

class ViewNote extends HookConsumerWidget {
  const ViewNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProvider = ref.watch(noteChangeNotifier);
    Note note = noteProvider.note;

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
          colorId: noteProvider.colorId,
          userId: note.userId,
          isPinned: note.isPinned,
          uid: note.uid,
        ),
      );
      Constants.showSnackBar(context, "Note updated!");
      Navigator.pop(context);
    }

    void _handleDelete() {
      final noteRepository = ref.watch(noteRepositoryProvider);
      noteRepository.deleteNote(note.uid ?? '');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Delete success!"),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Constants.notesColorList[noteProvider.colorId],
      appBar: AppBar(
        backgroundColor: Constants.notesColorList[noteProvider.colorId],
        title: Text(note.title ?? 'Edit Note'),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () async {
              noteProvider.reversePinned();
            },
            icon: Icon(Icons.push_pin,
                color: note.isPinned ?? false ? Colors.black : Colors.grey),
          ),
          IconButton(
            onPressed: () async {
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
            NoteColor(
              currentColor: noteProvider.colorId,
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Title...'),
              style: Constants.titleStyle,
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
          _handleNoteSave();
        },
        tooltip: 'Update Note',
        icon: const Icon(Icons.edit),
        label: const Text('Update Note'),
      ),
    );
  }
}
