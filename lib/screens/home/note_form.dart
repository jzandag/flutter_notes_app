import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/note.dart';

class NoteForm extends HookConsumerWidget {
  NoteForm({Key? key}) : super(key: key);
  String dateNow = DateFormat.yMd().add_jm().format(DateTime.now());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<int> colorId =
        useState(Random().nextInt(Constants.notesColorList.length));

    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();

    void _handleNoteSave() {
      final noteRepository = ref.watch(noteRepositoryProvider);
      noteRepository.saveNote(
        Note(
          title: _titleController.text,
          note: _mainController.text,
          createDate: dateNow,
          colorId: colorId.value,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Note saved!"),
        duration: Duration(seconds: 2),
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Constants.notesColorList[colorId.value],
      appBar: AppBar(
        backgroundColor: Constants.notesColorList[colorId.value],
        title: Text("New Note"),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
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
