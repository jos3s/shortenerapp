import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/auth/login.request.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _loginFormState();
}

class _loginFormState extends State<LoginForm> {
  final loginFormKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            validator: _validateEmail,
            onSaved: (newValue) => {email = newValue},
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: _validatePassword,
            onSaved: (newValue) => {password = newValue},
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await auth(state, context);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) return 'Email is not empty';
    return null;
  }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) return 'Password is not empty';
    return null;
  }

  Future<void> auth(AppState state, BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();

      var response = await ShortenerApi().login(
        LoginRequest(email: email!, password: password!),
      );

      state.saveToken(response.accessToken);

      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
