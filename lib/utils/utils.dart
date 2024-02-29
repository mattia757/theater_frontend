import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color hintTextStyleColor = Colors.deepPurple;
  static Color iconColor = Colors.deepPurple;
  static Color buttonColor = Colors.deepPurple;
  static Color buttonTextColor = Colors.white;
  static Color flushbarErrorColor = Colors.red;
}

class Utils {
  void onChangeFocusNode(BuildContext context, currentFocusNode, nextFocusNode) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  void showErrorFlushBar(BuildContext context, String title, String message) {
    Flushbar(
      title: title,
      message: message,
      margin: const EdgeInsets.symmetric (horizontal: 10, vertical: 15),
      padding: const EdgeInsets.all (15),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition. TOP,
      backgroundColor: AppColors.flushbarErrorColor,
      positionOffset: 20,
      borderRadius: BorderRadius.circular (15),
      icon: const Icon(Icons.error_outline),
    ).show(context);
  }
}