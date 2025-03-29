import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';
import 'package:shortenerapp/src/core/storage/secure_storage.dart';
import 'package:shortenerapp/src/shared/app_state.dart';
import 'package:shortenerapp/src/widgets/log_in.widget.dart';
import 'package:shortenerapp/src/widgets/url_card.widget.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final _secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _secureStorage.getToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _historic();
        } else {
          return LogInWidget();
        }
      },
    );
  }

  FutureBuilder<List<UrlShortenerResponse>> _historic() {
    return FutureBuilder(
      future: ShortenerApi().getAllUrl(),
      builder: (context, snapshot) {
        var isDataEmpty = snapshot.data == null;
        if (snapshot.hasData || !isDataEmpty) {
          if (snapshot.data!.isEmpty) {
            return _nothingWidget();
          }

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
          return _nothingWidget();
        }
      },
    );
  }

  Widget _nothingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('Nothing in historic')],
      ),
    );
  }
}
