import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/pages/app.page.dart';
import 'package:shortenerapp/src/pages/login/login.page.dart';
import 'package:shortenerapp/src/shared/app_state.dart';
import 'package:shortenerapp/src/shared/routes.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR').then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortener',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/',
    );
  }
}
