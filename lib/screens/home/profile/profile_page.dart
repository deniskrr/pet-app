import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/profile/edit_profile_page.dart';
import 'package:pet_app/screens/home/profile/service_provider_profile_widget.dart';
import 'package:pet_app/screens/pets/my_pets/my_pets_page.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';
import 'package:pet_app/widgets/profile_picture.dart';

import '../../login/login_page.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = '/user-profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService _userService = services.get<UserService>();
  final AuthService _authService = services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
      ),
      body: FutureBuilder(
        future: _userService.getUser(_authService.currentUserUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final User currentUser = snapshot.data;
            return Center(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      ProfilePicture(
                        image: null,
                        pictureUrl: currentUser.pictureUrl,
                        placeholderImageUri: "assets/blank_profile.png",
                        imageGetter: null
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        currentUser.username,
                        style: TextStyle(fontSize: 24,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        child: Text("Edit Profile"),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(
                                EditProfilePage.routeName,
                                arguments: currentUser),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        child: Text("My Pets"),
                        onPressed: () {
                          Navigator.of(context).pushNamed(MyPetsPage.routeName);
                        },
                      ),
                      if (currentUser.isServiceProvider) ServiceProviderWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        child: Text("Log out"),
                        onPressed: () {
                          _authService.signOut();
                          Navigator.of(context)
                              .pushReplacementNamed(LoginPage.routeName);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
