import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Register extends HookConsumerWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: GestureDetector(onTap: () => toggleView(), child: Text("Register")),
    );
  }
}
