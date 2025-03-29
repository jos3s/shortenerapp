import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';
import 'package:shortenerapp/src/pages/home/home.form.dart';
import 'package:shortenerapp/src/shared/app_state.dart';
import 'package:shortenerapp/src/widgets/url_card.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HomeForm(),
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
    );
  }
}
