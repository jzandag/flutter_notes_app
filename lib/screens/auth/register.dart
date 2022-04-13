import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_notes_app/common/common.dart';
import 'package:flutter_notes_app/common/shared/Loading.dart';
import 'package:flutter_notes_app/providers/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Register extends HookConsumerWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = useState(false);
    final email = useState("");
    final password = useState("");
    final confirmPassword = useState("");
    final errorMsg = useState("");
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    void _handleSubmit() async {
      loadingState.value = true;
      dynamic result = await ref
          .read(authControllerProvider.notifier)
          .registerUsingEmailAndPassword(email.value, password.value);
      if (result == null) {
        errorMsg.value = 'Failed to register using email/password';
        print('error' + errorMsg.value);
      }
      loadingState.value = false;
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
                  margin: EdgeInsets.only(top: 100),
                  child: Image.asset('assets/notes-logo.png'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
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
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password'),
                          obscureText: true,
                          onChanged: (val) {
                            confirmPassword.value = val;
                          },
                          validator: (val) {
                            return val != password.value
                                ? 'Passwords are not matching'
                                : null;
                          },
                          style: textStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print('success validate');
                              _handleSubmit();
                            }
                          },
                          color: Color(0xff99E2B4),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            errorMsg.value,
                            style: errorStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Already have an account?',
                    style: textStyle,
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sign in here',
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
