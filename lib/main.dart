import 'package:flutter/material.dart';
import 'package:pet_app/screens/login/login_page.dart';
import 'package:pet_app/screens/register/register_page.dart';
import 'package:pet_app/services/services.dart';

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
