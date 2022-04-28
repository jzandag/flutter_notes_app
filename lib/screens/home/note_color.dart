import 'package:flutter/material.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteColor extends HookConsumerWidget {
  final int currentColor;
  const NoteColor({Key? key, required this.currentColor}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenData = MediaQuery.of(context).size;
    final noteProvider = ref.watch(noteChangeNotifier);
    return Row(
      children: _buildColorButtons(
          screenData.height * 0.05, noteProvider.changeColor),
    );
  }

  List<Widget> _buildColorButtons(double height, Function onChangeColor) {
    return Constants.notesColorList
        .asMap()
        .entries
        .map(
          (entry) => Expanded(
            child: InkWell(
              onTap: () {
                onChangeColor(entry.key);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                    color: entry.value),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: height,
                child:
                    currentColor == entry.key ? const Icon(Icons.check) : null,
              ),
            ),
          ),
        )
        .toList();
  }
}
