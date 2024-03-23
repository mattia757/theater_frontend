import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../widgets/custom_card.dart';
import '../widgets/login_user_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomCard(
                            child: LoginPage(),
                          )
                        ]
                    )
                )
            )
        )
    );
  }


}
