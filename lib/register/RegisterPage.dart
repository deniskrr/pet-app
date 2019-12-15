import 'package:flutter/material.dart';
import 'package:pet_app/login/LoginForm.dart';
import 'package:pet_app/register/RegisterForm.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RegisterForm(
          registerHandler: (email, password) async {
            //TODO Register user
          }
        ),
      ),
    );
  }
}
