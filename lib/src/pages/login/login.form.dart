import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/auth/login.request.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
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

  Future<void> auth(AppState state, BuildContext context) async {
    var response = await ShortenerApi().login(
      LoginRequest(email: 'shortener@gmail.com', password: '11111'),
    );

    state.saveToken(response.accessToken);

    Navigator.of(context).pushReplacementNamed('/home');
  }
}
