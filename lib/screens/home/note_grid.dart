import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/screens/home/view_note.dart';

import '../../model/note.dart';

class NoteGrid extends HookWidget {
  final Note note;
  const NoteGrid({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Note grid tap');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewNote(note: note)));
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          color: Constants.notesColorList[note.colorId ?? 0],
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title ?? '',
                style: Constants.titleStyle,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(note.createDate ?? ''),
              const SizedBox(
                height: 6,
              ),
              Expanded(child: Text(note.note ?? ''))
            ],
          )),
    );
  }
}
