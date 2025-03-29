import 'package:shortenerapp/src/pages/app.page.dart';
import 'package:shortenerapp/src/pages/login/login.page.dart';

var routes = {
  '/login': (context) => LoginPage(),
  '/': (context) => AppPage(title: 'Shortener App'),
};
