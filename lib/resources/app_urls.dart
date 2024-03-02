class AppUrls {
  static var baseUrl = "http://localhost:8080/api";

  //USER URLS
  static var baseUserUrl = "$baseUrl/user";
  static var registerUser = "$baseUrl/v1/auth/register";
  static var loginUser = "$baseUrl/v1/auth/authenticate";
  static var getUsers = "$baseUserUrl/users";
}