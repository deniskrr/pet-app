import 'package:flutter/material.dart';
import 'package:pet_app/screens/register/register_form.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RegisterForm(
              registerHandler: (email, password) async {
                _authService.signUp(email, password);
              },
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushReplacementNamed("/login"),
              child: Text("Already have an account?"),
            )
          ],
        ),
      ),
    );
  }
}
