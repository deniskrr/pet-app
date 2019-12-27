import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService _userService = services.get<UserService>();
  final AuthService _authService = services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _userService.getUser(_authService.currentUserUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final User currentUser = snapshot.data;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://store.playstation.com/store/api/chihiro/00_09_000/container/RO/en/999/EP0149-CUSA09988_00-AV00000000000002/1553528383000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    currentUser.username,
                    style: Theme
                        .of(context)
                        .primaryTextTheme
                        .title
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NiceButton(
                    radius: 40,
                    fontSize: Theme
                        .of(context)
                        .primaryTextTheme
                        .title
                        .fontSize,
                    padding: const EdgeInsets.all(15),
                    text: "Edit info",
                    icon: Icons.edit,
                    background: Theme
                        .of(context)
                        .primaryColor,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NiceButton(
                    radius: 40,
                    fontSize: Theme
                        .of(context)
                        .primaryTextTheme
                        .title
                        .fontSize,
                    padding: const EdgeInsets.all(15),
                    text: "Add pet",
                    icon: Icons.add,
                    background: Theme
                        .of(context)
                        .primaryColor,
                    onPressed: () {},
                  )
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
