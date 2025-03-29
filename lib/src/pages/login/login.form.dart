import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/pages/login/login.controller.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginFormKey = GlobalKey<FormState>();
  final _loginController = LoginController();

  @override
  void initState() {
    super.initState();
    _loginController.fetchSecureStorageData();
  }

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
          _emailFormField(),
          SizedBox(height: 20),
          _passwordFormField(),
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

  TextFormField _emailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
      ),
      validator: _loginController.validateEmail,
      controller: _loginController.emailController,
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: _loginController.validatePassword,
      controller: _loginController.passwordController,
      obscureText: true,
    );
  }

  Future<void> auth(AppState state, BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();

      try {
        await _loginController.login();

        Navigator.of(context).pushReplacementNamed('/');
      } catch (ex) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(ex.toString())));
      }
    }
  }
}
