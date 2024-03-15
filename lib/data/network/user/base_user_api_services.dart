import 'package:flutter/cupertino.dart';

abstract class BaseUserApiServices {
  Future<dynamic> getGetApiResponse(BuildContext context, String url);
  Future<dynamic> getPostApiResponse(BuildContext context, String url, dynamic data);
  Future<dynamic> getDeleteApiResponse(BuildContext context, String url);
}