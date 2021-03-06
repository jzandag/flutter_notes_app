import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/common/shared/loading.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignIn extends HookConsumerWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = useState(false);
    final email = useState("");
    final password = useState("");
    final errorMsg = useState("");
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    void _handleSubmit() async {
      loadingState.value = true;
      dynamic result = await ref
          .read(authRepositoryProvider)
          .signInUsingEmailAndPassword(email.value, password.value);
      if (result == null) {
        errorMsg.value = 'Failed to sign in using email/password';
        loadingState.value = false;
      }
    }

    return loadingState.value
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 100),
                  child: Image.asset('assets/notes-logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Email', labelText: 'Email'),
                          onChanged: (val) {
                            email.value = val;
                          },
                          validator: (val) {
                            return val!.isEmpty ? 'Enter an email' : null;
                          },
                          style: textStyle,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password', labelText: 'Password'),
                          obscureText: true,
                          onChanged: (val) {
                            password.value = val;
                          },
                          validator: (val) {
                            return val!.isEmpty ? 'Enter your password' : null;
                          },
                          style: textStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _handleSubmit();
                            }
                          },
                          color: const Color(0xff99E2B4),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(errorMsg.value, style: errorStyle),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Want to register for an account?',
                    style: textStyle,
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Register here',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              toggleView();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
