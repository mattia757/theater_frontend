import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theater_frontend/utils/routes/routes_name.dart';

import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/register_screen.dart';
import '../../view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RoutesName.register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: Text("No Routes Defined"),
                ),
              );
            }
        );
    }
  }
}