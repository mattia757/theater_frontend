import 'dart:convert';
import 'dart:js';
import 'dart:js_util';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../data/exceptions/app_exceptions.dart';
import '../data/network/user/base_user_api_services.dart';
import '../data/network/user/user_network_response.dart';
import '../model/user_model.dart';
import '../resources/app_urls.dart';

class AuthRepository{
  final BaseUserApiServices _userApiServices = UserNetworkResponse();

  Future<dynamic> userRegister(BuildContext context, dynamic data) async {
    Response response = await _userApiServices.getPostApiResponse(context, AppUrls.registerUser, data);
    if (response.statusCode == 200) {
      return response.data;
    }
    else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> userLogin(dynamic data, BuildContext context) async {
      Response response = await _userApiServices.getPostApiResponse(context, AppUrls.loginUser, data);

      if (response.statusCode == 200) {
        return response.data;
      }
      else {
        throw Exception('Failed to load data');
      }
  }

  Future<Response<dynamic>> getUsers(BuildContext context) async {
    try {
      dynamic response = await _userApiServices.getGetApiResponse(context, AppUrls.getUsers);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getIdFromUsername(BuildContext context, String username) async {
    try {
      Response response = await _userApiServices.getGetApiResponse(context, AppUrls.getUser + username);

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteUser(BuildContext context, String username) async {
    try {
      var idUser = await getIdFromUsername(context, username);
      dynamic response = await _userApiServices.getDeleteApiResponse(context, AppUrls.deleteUser + idUser.data.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }
}