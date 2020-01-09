import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/login/login_page.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';

class SplashPage extends StatelessWidget {
  static final routeName = '/splash';
  final AuthService _authService = services.get<AuthService>();

  void navigateToPage(BuildContext context) async {
    final isCurrentUserLoggedIn = await _authService.isUserLoggedIn();
    if (isCurrentUserLoggedIn) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    navigateToPage(context);
    return Scaffold(
      body: Container(),
    );
  }
}
