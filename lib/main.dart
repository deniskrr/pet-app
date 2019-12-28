import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/home/profile/edit_profile_page.dart';
import 'package:pet_app/screens/login/login_page.dart';
import 'package:pet_app/screens/pets/add-pet/add_pet_page.dart';
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
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        HomePage.routeName: (context) => HomePage(),
        EditProfilePage.routeName: (context) => EditProfilePage(),
        AddPetPage.routeName: (context) => AddPetPage()
      },
    );
  }
}
