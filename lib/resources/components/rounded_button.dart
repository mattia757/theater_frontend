import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onPress,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
              color: Colors.white,
            )
                : Text(
              title,
              style: TextStyle(
                  color: AppColors.buttonTextColor,
                  fontSize: 18
              ),
            ),
          ),
        )
    );
  }
}