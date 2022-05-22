import 'package:flutter/material.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:flutter_notes_app/screens/home/view_note.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/note.dart';

class NoteGrid extends HookConsumerWidget {
  final Note note;
  const NoteGrid({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProvider = ref.watch(noteChangeNotifier);

    Widget getImages() {
      if (note != null && note.images != null) {
        if (note.images?.isNotEmpty == true) {
          return Image.network(
            note.images?.elementAt(0) ?? '',
            fit: BoxFit.contain,
          );
        }
      }
      return Container();
    }

    return InkWell(
      onTap: () {
        noteProvider.setNote(note);
        noteProvider.colorId = note.colorId ?? 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ViewNote()));
      },
      child: Container(
        height: 700,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: note.isPinned == true
                ? Border.all(color: Colors.black, width: 3)
                : null,
            color: Constants.notesColorList[note.colorId ?? 0]),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                note.isPinned == true
                    ? const Icon(
                        Icons.push_pin,
                        color: Colors.orange,
                      )
                    : Container(),
                Text(
                  note.title ?? '',
                  style: Constants.titleStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(note.createDate ?? ''),
            const SizedBox(
              height: 6,
            ),
            Expanded(child: Text(note.note ?? '')),
            getImages()
          ],
        ),
      ),
    );
  }
}
