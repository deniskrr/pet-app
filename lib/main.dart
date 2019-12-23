import 'package:flutter/material.dart';
import 'package:pet_app/screens/login/LoginPage.dart';
import 'package:pet_app/screens/register/RegisterPage.dart';
import 'package:pet_app/services/Services.dart';

void main() {
  initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
