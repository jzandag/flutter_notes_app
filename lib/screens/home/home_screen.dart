import 'package:flutter/material.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("home"), actions: [
        IconButton(
            onPressed: () async {
              await authControllerState.signOut();
            },
            icon: const Icon(Icons.logout))
      ]),
      body: Text("Home screen"),
    );
  }
}
