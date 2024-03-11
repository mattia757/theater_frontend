import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/model_view/auth_view_model.dart';
import 'package:theater_frontend/utils/Validator.dart';

import '../resources/components/rounded_button.dart';
import '../utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  void initState() {
    /*final SplashScreenServices _splashScreenServices = SplashScreenServices();
    _splashScreenServices.checkAuthentication(context as BuildContext);*/
    super.initState();
  }


  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _surnameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _rePasswordFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureRePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
                hintStyle: TextStyle(
                  color: AppColors.hintTextStyleColor,
                ),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.iconColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils().onChangeFocusNode(context, _nameFocusNode, _surnameFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _surnameController,
              focusNode: _surnameFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter your surname',
                labelText: 'Surname',
                hintStyle: TextStyle(
                  color: AppColors.hintTextStyleColor,
                ),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.iconColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils().onChangeFocusNode(context, _surnameFocusNode, _emailFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
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
                Utils().onChangeFocusNode(context, _emailFocusNode, _passwordFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _obscurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword.value,
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
                        _obscurePassword.value = !_obscurePassword.value;
                      },
                      child: Icon(
                        _obscurePassword.value
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
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _obscureRePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureRePassword.value,
                  obscuringCharacter: '*',
                  focusNode: _rePasswordFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    labelText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: AppColors.hintTextStyleColor,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_clock_outlined,
                      color: AppColors.iconColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _obscureRePassword.value = !_obscureRePassword.value;
                      },
                      child: Icon(
                        _obscureRePassword.value
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
                return RoundedButton(
                  title: 'Register',
                  onPress: () {
                    // Validazione dei campi
                    String? nameError = Validator.validateName(
                        _nameController.text, context);
                    String? surnameError = Validator.validateSurname(
                        _surnameController.text, context);
                    String? emailError = Validator.validateEmail(
                        _emailController.text, context);
                    String? passwordError = Validator.validatePassword(
                        _passwordController.text, context);
                    String? confirmPasswordError = Validator
                        .validateConfirmPassword(_passwordController.text,
                        _confirmPasswordController.text, context);

                    if (nameError != 'Validate' || surnameError != 'Validate' ||
                        emailError != 'Validate' || passwordError != 'Validate' ||
                        confirmPasswordError != 'Validate') {
                      print('Ci sono errori di validazione nei campi');
                    } else {
                      Map data = {
                        'name': _nameController.text,
                        'surname': _surnameController.text,
                        'email': _emailController.text,
                        'password': _passwordController.text,
                        'CustomType': 'registrationUser'
                      };
                      authViewModel.registerApi(data, context);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}