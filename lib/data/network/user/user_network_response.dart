import 'dart:convert';
import 'dart:io';
import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../model/user_model.dart';
import '../../exceptions/app_axceptions.dart';
import 'base_user_api_services.dart';

class UserNetworkResponse extends BaseUserApiServices {

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
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
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Error during Get Request');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Access-Control-Allow-Origin": "*",
          },
        ),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Error during Post request');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.data is List) {

          return (response.data as List).map((item) => UserList.fromJson(item)).toList();

        } else if (response.data is String) {

          dynamic responseJson = jsonDecode(response.data);
          return responseJson;

        } else {

          return response.data;

        }
      case 503:
        throw UnauthorisedException("You don't have authorization");
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}