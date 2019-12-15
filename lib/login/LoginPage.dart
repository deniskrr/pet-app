import 'package:flutter/material.dart';
import 'package:pet_app/login/LoginForm.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginForm(
          loginHandler: (email, password) async {
            //TODO Login user
          }
        ),
      ),
    );
  }
}
