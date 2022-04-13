import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/UserData.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:flutter_notes_app/screens/home/note_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.read(authControllerProvider.notifier);
    UserData usrData = sampleUserData();

    return Scaffold(
      appBar: AppBar(title: Text("home"), actions: [
        IconButton(
          onPressed: () async {
            await authControllerState.signOut();
          },
          icon: const Icon(Icons.logout),
        )
      ]),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(usrData.data?.length ?? 0, (index) {
          return NoteGrid(
              note: usrData.data?[index].note ?? '', isPinned: false);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          print('Add note btn click');
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
