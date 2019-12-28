import 'package:flutter/material.dart';
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Text("Edit info"),
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Text("Add pet"),
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
