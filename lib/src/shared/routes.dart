import 'package:shortenerapp/src/pages/app.page.dart';
import 'package:shortenerapp/src/pages/login/login.page.dart';

var routes = {
  '/': (context) => LoginPage(),
  '/home': (context) => AppPage(title: 'Shortener App'),
};
