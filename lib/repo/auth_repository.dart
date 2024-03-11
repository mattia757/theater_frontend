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

  Future<dynamic> userRegister(dynamic data, BuildContext context ) async {
    try {
      dynamic response = await _userApiServices.getPostApiResponse(context, AppUrls.registerUser, data);

      return response;
    } catch (e) {
      rethrow;
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
      //return response;
  }

  Future <Response<dynamic>> getUsers(BuildContext context) async {
    try {
      dynamic response = await _userApiServices.getGetApiResponse(context, AppUrls.getUsers);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}