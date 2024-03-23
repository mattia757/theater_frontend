import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model_view/auth_view_model.dart';
import '../resources/components/rounded_button.dart';
import '../utils/Validator.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  Future<bool> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Riduce la dimensione della card al contenuto
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  hintText: 'Inserisci lo Username',
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onFieldSubmitted: (value) {
                  Utils().onChangeFocusNode(context, _usernameFocusNode, _passwordFocusNode);
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureText,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: value,
                    obscuringCharacter: '*',
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _obscureText.value = !_obscureText.value;
                        },
                        child: Icon(
                          value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return Column(
                    children: [
                      RoundedButton(
                        title: "Login",
                        onPress: () async {
                          if (Validator.validateUsername(_usernameController.text, context) == 'Validate' &&
                              Validator.validatePassword(_passwordController.text, context) == 'Validate' &&
                              await _submitForm() == true) {
                            Map data = {
                              'username': _usernameController.text,
                              'password': _passwordController.text,
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
                      const SizedBox(height: 20),
                      RoundedButton(
                        title: "Register",
                        onPress: () {
                          context.go(RoutesName.register);
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
