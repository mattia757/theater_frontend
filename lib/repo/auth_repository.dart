import '../data/network/user/base_user_api_services.dart';
import '../data/network/user/user_network_response.dart';
import '../resources/app_urls.dart';

class AuthRepository{
  final BaseUserApiServices _userApiServices = UserNetworkResponse();

  Future<dynamic> userRegister(dynamic data) async {
    try {
      dynamic response = await _userApiServices.getPostApiResponse(AppUrls.registerUser, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}