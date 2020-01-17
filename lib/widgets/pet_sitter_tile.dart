import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';

class PetSitterTile extends StatelessWidget {
  final User petSitter;

  const PetSitterTile({Key key, @required this.petSitter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: petSitter.pictureUrl.isEmpty
            ? Image.asset(
                "assets/blank_profile.png",
              )
            : Image.network(
                petSitter.pictureUrl,
              ),
        title: Text(petSitter.username),
        subtitle: Text(petSitter.bio),
        trailing: new IconButton(
          icon: new Icon(Icons.chat),
          onPressed: () async {
            UserService _userService = services.get<UserService>();
            AuthService _authService = services.get<AuthService>();
            User currentUser=await _userService.getUser(_authService.currentUserUid);
            if(!currentUser.conversations.contains(petSitter.uid)){
              currentUser.conversations.add(petSitter.uid);
            }
            _userService.updateUser(currentUser);

            Navigator.of(context)
                .pushNamed(ChatPage.routeName, arguments: petSitter.uid);
          },
        ));
  }
}
