import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';
import 'package:shortenerapp/src/forms/shortener.form.dart';
import 'package:shortenerapp/src/shared/app_state.dart';
import 'package:shortenerapp/src/widgets/url_card.widget.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.title});

  final String title;

  @override
  State<AppPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ShortenerForm(),
                SizedBox(height: 20),
                for (UrlShortenerResponse urlResponse in state.urlShorteners)
                  UrlCardWidget(
                    id: urlResponse.id,
                    url: urlResponse.url,
                    originalUrl: urlResponse.originalUrl,
                    creationAt: urlResponse.createdAt,
                    updatedAt: urlResponse.updatedAt,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
