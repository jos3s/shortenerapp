import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';
import 'package:shortenerapp/src/forms/shortener.form.dart';
import 'package:shortenerapp/src/pages/historic/historic.page.dart';
import 'package:shortenerapp/src/pages/home/home.page.dart';
import 'package:shortenerapp/src/shared/app_state.dart';
import 'package:shortenerapp/src/shared/pages.enum.dart';
import 'package:shortenerapp/src/widgets/account.widget.dart';
import 'package:shortenerapp/src/widgets/url_card.widget.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.title});

  final String title;

  @override
  State<AppPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppPage> {
  Pages selectedPage = Pages.home;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    
    Widget page;
    switch (selectedPage) {
      case Pages.home:
        page = HomePage();
        break;
      case Pages.historic:
        page = HistoricPage();
        break;
    }


    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [AccountWidget()]),
      body: page,
      bottomNavigationBar: _navigationBar(),
    );
  }

  NavigationBar _navigationBar() {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        //NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        NavigationDestination(icon: Icon(Icons.history), label: 'Historic'),
      ],
      onDestinationSelected: (value) {
        setState(() {
          selectedPage = Pages.values[value];
        });
      },
      selectedIndex: selectedPage.index,
    );
  }
}
