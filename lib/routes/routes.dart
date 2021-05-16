import 'package:emp_app/Login/login.dart';
import 'package:emp_app/pages/home/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      default:
        return null;
    }
  }
}
