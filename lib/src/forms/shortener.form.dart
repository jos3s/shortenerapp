import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/url_shortener/create-url-shortener.request.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class ShortenerForm extends StatefulWidget {
  const ShortenerForm({super.key});

  @override
  State<ShortenerForm> createState() => _ShortenerFormState();
}

class _ShortenerFormState extends State<ShortenerForm> {
  final _formKey = GlobalKey<FormState>();

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
              onSaved: (newValue) => {url = newValue},
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

        state.addNewUrl(
          await ShortenerApi().post(
            CreateUrlShortenerRequest(url: url!),
          ),
        );

        _formKey.currentState!.reset();
      } catch (ex) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error')));
      }
    }
  }
}
