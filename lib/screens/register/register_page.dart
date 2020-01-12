import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/intro/intro_page.dart';
import 'package:pet_app/screens/register/register_form.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';

class RegisterPage extends StatefulWidget {
  static final routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = services.get<AuthService>();
  final UserService _userService = services.get<UserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RegisterForm(
              registerHandler: (email, username, password) async {
                _authService.signUp(email, password).then((value) =>
                    _userService
                        .createUser(email, username, value.user.uid)
                        .then((value) =>
                        Navigator.of(context)
                            .pushReplacementNamed(IntroPage.routeName)));
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
