import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/home/profile/edit_profile_page.dart';
import 'package:pet_app/screens/home/splash_page.dart';
import 'package:pet_app/screens/intro/intro_page.dart';
import 'package:pet_app/screens/login/login_page.dart';
import 'package:pet_app/screens/pets/add-edit-pet/add-edit_pet_page.dart';
import 'package:pet_app/screens/pets/my_pets/my_pets_page.dart';
import 'package:pet_app/screens/pets/pet-profile/pet_profile.dart';
import 'package:pet_app/screens/register/register_page.dart';
import 'package:pet_app/screens/services/add-edit-service/add-edit_service_page.dart';
import 'package:pet_app/screens/services/my-services/my_services_page.dart';
import 'package:pet_app/screens/services/service-profile/service_profile.dart';
import 'package:pet_app/services/services.dart';

void main() {
  initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color(0xFFFCAA7B),
        primaryColorLight: Color(0xFFFCBA94),
        primaryColorDark: Color(0xFFF27730),
        primaryColorBrightness: Brightness.dark,
        accentColor: Color(0xFFF27730),
        accentColorBrightness: Brightness.dark,
        backgroundColor: Color(0xFFFFF7EF),
        scaffoldBackgroundColor: Color(0xFFFFF7EF),
        dialogBackgroundColor: Color(0xFFFFFCF9),
        disabledColor: Color(0xFFCECECC),
        errorColor: Color(0xFFFF5242),

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),

        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFB9E5E4),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0),
            side: BorderSide(color: Color(0xFFB9E5F8))
          ),
          textTheme: ButtonTextTheme.normal,
          minWidth: 150.0,
          padding: EdgeInsets.all(15.0),
          alignedDropdown: true,
        )

      ),
      title: 'Pet App',
      initialRoute: SplashPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        HomePage.routeName: (context) => HomePage(),
        EditProfilePage.routeName: (context) => EditProfilePage(),
        AddEditPetPage.routeName: (context) => AddEditPetPage(),
        MyPetsPage.routeName: (context) => MyPetsPage(),
        AddEditServicePage.routeName: (context) => AddEditServicePage(),
        MyServicesPage.routeName: (context) => MyServicesPage(),
        ServiceProfile.routeName: (context) => ServiceProfile(),
        SplashPage.routeName: (context) => SplashPage(),
        IntroPage.routeName: (context) => IntroPage(),
        PetProfile.routeName: (context) => PetProfile()
      },

    );
  }
}
