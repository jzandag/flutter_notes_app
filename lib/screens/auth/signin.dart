import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignIn extends HookConsumerWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("sign in")),
      body: GestureDetector(
        child: Text("signin"),
        onTap: () => toggleView(),
      ),
    );
  }
}
