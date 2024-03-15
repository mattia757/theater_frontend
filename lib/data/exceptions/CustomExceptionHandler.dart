import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/utils.dart';
import 'app_exceptions.dart';

class CustomExceptionHandler {
  static void handleException(BuildContext context, dynamic exception) {
    if (exception is DioException) {
      if (exception.response?.statusCode == 401) {
        Utils().showErrorFlushBar(context, "Credenziali errate", "Utente non autorizzato");
        throw UnauthorisedException("Utente non autorizzato");
      } else if (exception.response?.statusCode == 404) {
        throw ResourceNotFoundException("Risorsa non trovata");
      } else if (exception.response?.statusCode == 409) {
        throw ConflictException("Conflitto");
      } else if (exception.response?.statusCode == 500) {
        throw InternalServerException("Errore interno del server");
      } else {
        print('Unhandled DioError: $exception');
        throw exception;
      }
    } else {
      // Gestisci altri tipi di eccezioni o rilancia
      print('Unhandled exception: $exception');
      throw exception;
    }
  }
}