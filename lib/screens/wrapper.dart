import 'package:flutter/material.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:flutter_notes_app/screens/auth/auth_wrapper.dart';
import 'package:flutter_notes_app/screens/home/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Wrapper extends HookConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);

    if (authControllerState == null) {
      return AuthWrapper();
    } else {
      return HomeScreen();
    }
  }
}
