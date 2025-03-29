import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class UrlCardWidget extends StatelessWidget {
  final int id;
  final String url;
  final String originalUrl;
  final DateTime creationAt;
  final DateTime updatedAt;

  const UrlCardWidget({
    super.key,
    required this.id,
    required this.url,
    required this.originalUrl,
    required this.creationAt,
    required this.updatedAt, 
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(url, style: TextStyle(fontSize: 20)),
                    Text(originalUrl, style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(children: [Text(DateFormat("dd-MM-yyyy").format(creationAt))]),
          ],
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: url)).then((_) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Copied url to your clipboard!')),
            );
          });
        },
        onLongPress: () {
          state.removeUrl(id);
          Clipboard.setData(ClipboardData(text: url)).then((_) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Removed url!')));
          });
        },
      ),
    );
  }
}
