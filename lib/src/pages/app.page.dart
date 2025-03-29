import 'package:flutter/material.dart';
import 'package:shortenerapp/src/pages/historic/historic.page.dart';
import 'package:shortenerapp/src/pages/home/home.page.dart';
import 'package:shortenerapp/src/shared/pages.enum.dart';

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
      appBar: AppBar(title: Text(widget.title)),
      body: page,
      bottomNavigationBar: _navigationBar(),
    );
  }

  NavigationBar _navigationBar() {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
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
