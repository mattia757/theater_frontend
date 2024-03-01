import 'package:flutter/cupertino.dart';
import 'package:theater_frontend/utils/utils.dart';

class Validator {
  static String? validateName(String value, BuildContext context) {
    if (value.isEmpty) {
      Utils().showErrorFlushBar(context, 'Name is required', 'Please Fill the Name');
      return 'Name is required';
    }
    return 'Validate';
  }

  static String? validateSurname(String value, BuildContext context) {
    if (value.isEmpty) {
      Utils().showErrorFlushBar(context, 'Surname is required', 'Please Fill the surname');
      return 'Surname is required';
    }
    return 'Validate';
  }

  static String? validateEmail(String value, BuildContext context) {
    if (value.isEmpty) {
      Utils().showErrorFlushBar(context, 'Email is required', 'Please Fill the surname');
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      Utils().showErrorFlushBar(context, 'Email must be correct Format', 'Please rewrite the email in the correct format');
      return 'Enter a valid email address';
    }
    return 'Validate';
  }

  static String? validatePassword(String value, BuildContext context) {
    if (value.isEmpty) {
      Utils().showErrorFlushBar(context, 'Password is required', 'Please Fill the Password');
      return 'Password is required';
    } else if (value.length < 6) {
      Utils().showErrorFlushBar(context, 'Password is too short', 'Password must be at least 6 characters');
      return 'Password must be at least 6 characters long';
    }
    return 'Validate';
  }

  static String? validateConfirmPassword(String password, String confirmPassword, BuildContext context) {
    if (confirmPassword.isEmpty) {
      Utils().showErrorFlushBar(context, 'Confirm Password is required', 'Please Fill the Confirm Password');
      return 'Confirm Password is required';
    } else if (password != confirmPassword) {
      Utils().showErrorFlushBar(context, 'Password and Confirm Password do not match', 'Please rewrite the password and confirm password');
      return 'Password and Confirm Password do not match';
    }
    return 'Validate';
  }
}
