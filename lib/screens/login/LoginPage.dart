import 'package:flutter/material.dart';
import 'package:pet_app/screens/login/LoginForm.dart';
import 'package:pet_app/services/Services.dart';
import 'package:pet_app/services/auth/AuthService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService= services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginForm(
          loginHandler: (email, password) async {
            _authService.signIn(email, password);
          }
        ),
      ),
    );
  }
}
