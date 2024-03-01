import 'dart:async';

import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../model_view/user_view_model.dart';
import '../utils/routes/routes_name.dart';

class SplashScreenServices {
  Future<UserModel> getUserData() {
    return UserViewModel().getUser();
  }

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) {
      if (value.token == null) {
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        Navigator.pushNamed(context, RoutesName.home);
      }
    });
  }

}