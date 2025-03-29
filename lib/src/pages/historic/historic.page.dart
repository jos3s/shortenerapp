import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';
import 'package:shortenerapp/src/shared/app_state.dart';
import 'package:shortenerapp/src/widgets/log_in.widget.dart';
import 'package:shortenerapp/src/widgets/url_card.widget.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return state.accessToken != null ? _historic(state) : LogInWidget();
  }
  

  FutureBuilder<List<UrlShortenerResponse>> _historic(AppState state){
    return FutureBuilder(
      future: ShortenerApi().getAllUrl(state.accessToken!),
      builder: (context, snapshot) {
        var isDataEmpty = snapshot.data != null;
        if (snapshot.hasData && isDataEmpty) {
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              Column(
                children: [
                  for (var response in snapshot.data!)
                    UrlCardWidget(
                      id: response.id,
                      url: response.url,
                      originalUrl: response.originalUrl,
                      creationAt: response.createdAt,
                      updatedAt: response.updatedAt,
                    ),
                ],
              ),
            ],
          );
        } else {
          return Text('Nothing');
        }
      },
    );
  }
}
