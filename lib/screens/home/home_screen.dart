import 'package:flutter/material.dart';
import 'package:flutter_notes_app/controller/note_controller.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:flutter_notes_app/screens/home/note_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'note_grid.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.read(authControllerProvider.notifier);
    UserData usrData = sampleUserData();
    final userNotes = ref.watch(noteControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Home"), actions: [
        IconButton(
          onPressed: () async {
            await authControllerState.signOut();
          },
          icon: const Icon(Icons.logout),
        )
      ]),
      body: userNotes?.data?.isNotEmpty ?? false
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: userNotes?.data?.length ?? 0,
              itemBuilder: (_, index) {
                Note? currNote = userNotes?.data?[index];
                return NoteGrid(
                  note: Note(
                      note: currNote?.note ?? '',
                      createDate: currNote?.createDate,
                      isPinned: currNote?.isPinned,
                      colorId: currNote?.colorId,
                      title: currNote?.title,
                      uid: currNote?.uid),
                );
              },
            )
          : const Center(
              child: Text("There's no notes"),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          print('Add note btn click');
          print(userNotes);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteForm()));
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  UserData sampleUserData() {
    UserData usr = new UserData(uid: 'hello');
    usr.data = [
      Note(note: 'sample'),
      Note(note: 'sample2'),
      Note(note: 'sample3'),
      Note(note: 'sampl4'),
      Note(note: 'sample5'),
    ];
    return usr;
  }
}
