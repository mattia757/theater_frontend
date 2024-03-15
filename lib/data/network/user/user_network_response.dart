import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../exceptions/CustomExceptionHandler.dart';
import '../../exceptions/app_exceptions.dart';
import 'base_user_api_services.dart';

class UserNetworkResponse extends BaseUserApiServices {

  @override
  Future<dynamic> getGetApiResponse(BuildContext context, String url) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Access-Control-Allow-Origin": "*",
          },
        ),
      );
      return response;
    } on dynamic catch (e) {
      CustomExceptionHandler.handleException(context, e);
    }
  }

  @override
  Future<dynamic> getPostApiResponse(BuildContext context, String url, dynamic data) async {
    try {
      final response = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {
            //"Authorization": "Bearer $token"},
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Access-Control-Allow-Origin": "*",
          },
        ),
      );
      return response;
    } on dynamic catch (e) {
      CustomExceptionHandler.handleException(context, e);
    }
  }

  @override
  Future<dynamic> getDeleteApiResponse(BuildContext context, String url) async {
    try {
      final response = await Dio().delete(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Access-Control-Allow-Origin": "*",
          },
        ),
      );
      return response;
    } on dynamic catch (e) {
      CustomExceptionHandler.handleException(context, e);
    }
  }

}