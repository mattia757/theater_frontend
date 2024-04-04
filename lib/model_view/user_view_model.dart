import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserViewModel with ChangeNotifier {

  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", user.token.toString());
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    return UserModel(token: token);
  }

  Future<bool> removeUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
    sharedPreferences.clear();
    return true;
  }

  final Dio _dio = Dio();
  // URL del tuo endpoint di logout
  final String _baseUrl = "http://localhost:8080/api/v1/auth/logout";

  Future<void> logout() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    if (token != null) {
      try {
        // Usando Dio per la chiamata di logout
        final response = await _dio.post(
          _baseUrl,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          // Se il logout ha successo, rimuovi il token JWT memorizzato localmente
          await sharedPreferences.remove("token");
          notifyListeners();
        } else {
          // Se il server risponde con un codice di errore
          throw Exception('Failed to logout on the server.');
        }
      } on DioError catch (e) {
        // Gestire gli errori specifici di Dio qui
        throw Exception('DioError during logout: ${e.message}');
      }
    }
  }


}