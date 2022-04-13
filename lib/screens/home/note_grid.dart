import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NoteGrid extends HookWidget {
  final String note;
  final bool isPinned;
  const NoteGrid({Key? key, required this.note, required this.isPinned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(note),
    );
  }
}
