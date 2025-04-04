import 'package:flutter/material.dart';
import 'package:shortenerapp/src/pages/login/login.form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shortener App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [LoginForm()]),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: Text('Skip'),
        ),
      ],
    );
  }
}
