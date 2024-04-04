import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/model_view/user_view_model.dart';

import '../data/exceptions/app_exceptions.dart';
import '../data/response/api_responses.dart';
import '../model/user_model.dart';
import '../repo/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool loading = false;
  ApiResponse<List<UserList>> usersList = ApiResponse.loading();

  Future<void> registerApi(BuildContext context, dynamic data) async {
    loading = true;
    notifyListeners();

    _myRepo.userRegister(context, data).then((value) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Success", "Registration Successful");

      final userModelViewModel =
      Provider.of<UserViewModel>(context, listen: false);

      //userModelViewModel.saveUser(UserModel(token: value.toString()));
      context.go(RoutesName.home);
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Error", error.toString());
    });
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    loading = true;
    notifyListeners();

    _myRepo.userLogin(data, context).then((value) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Success", "Login Successful");
      final userModelViewModel =
            Provider.of<UserViewModel>(context, listen: false);

      userModelViewModel.saveUser(UserModel(token: value.toString()));
      context.go(RoutesName.home);
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();

      print(error.toString());
      print(stackTrace);
    });
  }

  Future<ApiResponse<List<UserList>>> getUsersApi(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      final value = await _myRepo.getUsers(context);

      try {
        usersList = ApiResponse.completed(UserList.fromJsonList(value.data));
        
      } catch (e) {
        throw Exception('Error during conversion');
      }

      loading = false;
      notifyListeners();

      //usersList = ApiResponse.completed(value.cast<UserList>());
      Utils().showErrorFlushBar(context, "Success", "Get Users Successful");
      return usersList;
    } catch (error, stackTrace) {
      loading = false;
      usersList = ApiResponse.error(error.toString());
      notifyListeners();

      print(error.toString());
      Utils().showErrorFlushBar(context, "Error", error.toString());

      // Puoi decidere se rilanciare l'eccezione o gestirla in modo diverso a seconda delle tue esigenze.
      throw Exception(error.toString());
    }
  }



}
