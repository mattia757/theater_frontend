import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/utils/Validator.dart';

import '../model_view/auth_view_model.dart';
import '../resources/components/rounded_button.dart';
import '../utils/utils.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter your username',
                labelText: 'Username',
                hintStyle: TextStyle(
                  color: AppColors.hintTextStyleColor,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.iconColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils().onChangeFocusNode(context, _usernameFocusNode, _passwordFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _obscureText,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText.value,
                  obscuringCharacter: '*',
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    hintStyle: TextStyle(
                      color: AppColors.hintTextStyleColor,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_clock_outlined,
                      color: AppColors.iconColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _obscureText.value = !_obscureText.value;
                      },
                      child: Icon(
                        _obscureText.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.iconColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20,),

            Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                return Column(
                  children: [
                    RoundedButton(
                      title: "Login",
                      onPress: () {
                        if(
                            Validator.validateUsername(_usernameController.text, context) != 'Validate' ||
                            Validator.validatePassword(_passwordController.text, context) != 'Validate'
                        ){}
                        else {
                          Map data = {
                            'username': _usernameController.text.toString(),
                            'password': _passwordController.text.toString(),
                            'CustomType': 'authenticationUser',
                          };
                          try {
                            authViewModel.loginApi(jsonEncode(data), context);
                          } catch (e) {
                            Utils().showErrorFlushBar(context, "Error", e.toString());
                            rethrow;
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    RoundedButton(
                      title: "Register",
                      onPress: () {
                        // Naviga alla schermata di registrazione
                        context.go(RegisterScreen() as String);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
