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
