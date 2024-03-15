import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:theater_frontend/model/user_model.dart';
import 'package:theater_frontend/utils/routes/routes_name.dart';

import '../../model_view/user_view_model.dart';
import '../../view/delete_user_screen.dart';
import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/register_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> staticRoutes = {
    RoutesName.home: (context) => HomeScreen(),
    RoutesName.login: (context) => LoginScreen(),
    RoutesName.register: (context) => RegisterScreen(),
  };

  static Future<String?> checkAuth(String redirectRoute) async {
    final UserModel user = await UserViewModel().getUser();
    if (user.token == null) {
      return redirectRoute;
    } else {
      return null;
    }
  }

  static final routerConfig = GoRouter(
    initialLocation: RoutesName.login,
    routes: [
      GoRoute(
        path: RoutesName.home,
        builder: (context, state) => HomeScreen(),
        redirect: (context, state) async {
          return await checkAuth(RoutesName.login);
        }
      ),
      GoRoute(
        path: RoutesName.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RoutesName.register,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
          path: RoutesName.delete,
          builder: (context, state) => DeleteUserScreen(),
      )
    ],
  );
}