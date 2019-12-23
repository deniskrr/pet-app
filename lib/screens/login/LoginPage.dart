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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            LoginForm(
                loginHandler: (email, password) async {
                  _authService.signIn(email, password);
                }
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacementNamed("/register"),
              child: Text("Don't have an account?"),
            )
          ],
        ),
      ),
    );
  }
}
