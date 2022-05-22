import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageContainer extends HookConsumerWidget {
  final filePath;
  const ImageContainer({Key? key, this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteProvider = ref.watch(noteChangeNotifier);

    return Stack(
      children: [
        Image.file(File(filePath)),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              noteProvider.removeImage(filePath);
            },
            icon: const Icon(
              Icons.highlight_remove_sharp,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
