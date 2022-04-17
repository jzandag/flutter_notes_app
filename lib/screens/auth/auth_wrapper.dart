import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_notes_app/screens/auth/register.dart';
import 'package:flutter_notes_app/screens/auth/signin.dart';

class AuthWrapper extends HookWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> showSignIn = useState(true);
    void toggleView() {
      showSignIn.value = !showSignIn.value;
    }

    if (showSignIn.value) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
