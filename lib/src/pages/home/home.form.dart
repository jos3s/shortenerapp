import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/pages/home/home.controller.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  final _formKey = GlobalKey<FormState>();
  final _homeController = HomeController();

  String? url;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Url',
              ),
              initialValue: url,
              controller: _homeController.urlController,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _shortener(state),
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shortener(AppState state) async {
    if (_formKey.currentState!.validate()) {
      try {
        _formKey.currentState!.save();

        _homeController.saveNewUrl(state);
        
        _formKey.currentState!.reset();
      } catch (ex) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error')));
      }
    }
  }
}
