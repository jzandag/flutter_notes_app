import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../model/note.dart';

class NoteGrid extends HookWidget {
  final Note note;
  const NoteGrid({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Text(note.note ?? ''),
      ),
    );
  }
}
