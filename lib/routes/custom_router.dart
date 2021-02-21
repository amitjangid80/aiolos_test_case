import 'package:flutter/material.dart';

import 'package:aiolos_test_case/routes/routes.dart';
import 'package:aiolos_test_case/screens/screens.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => DashboardScreen());

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}