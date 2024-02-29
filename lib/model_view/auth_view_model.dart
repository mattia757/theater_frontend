import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/model/user_model.dart';
import 'package:theater_frontend/model_view/user_view_model.dart';
import 'package:theater_frontend/repo/auth_repository.dart';

import '../data/network/user/user_network_response.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _userRepo = AuthRepository();
  bool loading = false;

  Future<void> registerUser(dynamic data, BuildContext context) async {
    loading = true;
    notifyListeners();

    _userRepo.userRegister(data).then((value) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Success", "Login Successful");
      final userModelViewModel = Provider.of<UserViewModel>(context, listen: false);

      userModelViewModel.saveUser(UserModel(token: value.toString()));
      Navigator.pushNamed(context, RoutesName.home);
    })
  }
}