import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/model_view/user_view_model.dart';

import '../data/response/api_responses.dart';
import '../model/user_model.dart';
import '../repo/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool loading = false;
  ApiResponse<List<UserList>> usersList = ApiResponse.loading();

  Future<void> registerApi(dynamic data, BuildContext context) async {
    loading = true;
    notifyListeners();

    _myRepo.userRegister(data).then((value) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Success", "Registration Successful");

      final userModelViewModel =
      Provider.of<UserViewModel>(context, listen: false);

      userModelViewModel.saveUser(UserModel(token: value.toString()));
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Error", error.toString());
    });
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    loading = true;
    notifyListeners();

    _myRepo.userLogin(data).then((value) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Success", "Login Successful");
      final userModelViewModel =
            Provider.of<UserViewModel>(context, listen: false);

      userModelViewModel.saveUser(UserModel(token: value.toString()));
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Error", error.toString());
    });
  }

  Future<void> getUsersApi(BuildContext context) async {
    loading = true;
    notifyListeners();

    _myRepo.getUsers().then((value) {
      loading = false;
      notifyListeners();

      usersList = ApiResponse.completed(value.cast<UserList>());
      Utils().showErrorFlushBar(context, "Success", "Get Users Successful");
        }).onError((error, stackTrace) {
      loading = false;
      usersList = ApiResponse.error(error.toString());
      notifyListeners();

      print(error.toString());
      Utils().showErrorFlushBar(context, "Error", error.toString());
    });
  }


}
