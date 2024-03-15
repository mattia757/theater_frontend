class AppException implements Exception {
  final _message;
  AppException(this._message);

  @override
  String toString() {
    return "$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super("Error during communication");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super("Invalid Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super("Unauthorised Request");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super("Invalid Input");
}

class BadCredentialsException extends AppException {
  BadCredentialsException([String? message]) : super("Bad Credentials");
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException([String? message]) : super("Resource Not Found");
}

class ConflictException extends AppException {
  ConflictException([String? message]) : super("Conflict");
}

class InternalServerException extends AppException {
  InternalServerException([String? message]) : super("Internal Server Error");
}