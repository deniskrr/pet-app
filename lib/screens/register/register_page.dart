import 'package:flutter/material.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/helpers/error_messages.dart';
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
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          new Container(
            height: 140.0,
            width: 140.0,
            margin: const EdgeInsets.all(30),
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/logo.png'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          Container(
            decoration: BoxDecoration(
//              color: Color(0xFFF4EDE9),
              borderRadius: const BorderRadius.all(const Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RegisterForm(
                  registerHandler: (email, username, password) async {
                    _authService
                        .signUp(email, password)
                        .then((value) => _userService
                            .createUser(email, username, value.user.uid)
                            .then((value) => Navigator.of(context)
                                .pushReplacementNamed(IntroPage.routeName)))
                        .catchError((error, stackTrace) {
                      AppDialogs.showAlertDialog(context, "Register failed",
                          ErrorMessages.getErrorMessage(error));
                    });
                  },
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed("/login"),
                  child: Text("Already have an account?"),
                )
              ],
            ),
          ),
        ])));
  }
}
