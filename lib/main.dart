import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theater_frontend/utils/routes/routes.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'model_view/auth_view_model.dart';
import 'model_view/user_view_model.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: Routes.routerConfig,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}