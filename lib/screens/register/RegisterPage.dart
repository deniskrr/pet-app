import 'package:flutter/material.dart';
import 'package:pet_app/screens/register/RegisterForm.dart';
import 'package:pet_app/services/Services.dart';
import 'package:pet_app/services/auth/AuthService.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService= services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RegisterForm(
          registerHandler: (email, password) async {
            _authService.signUp(email, password);
          }
        ),
      ),
    );
  }
}
