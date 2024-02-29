import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../exceptions/app_axceptions.dart';
import 'base_user_api_services.dart';

class UserNetworkResponse extends BaseUserApiServices {

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
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
      final response = await http.post(Uri.parse(url), body: data)
      .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response as http.Response);
    } on SocketException {
      throw FetchDataException('Error during Post request');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 503:
        throw UnauthorisedException("You don't have authorization");
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}