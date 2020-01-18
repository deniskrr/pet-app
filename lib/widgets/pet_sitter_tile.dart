import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/pet-sitter/pet_sitter_profile_page.dart';
import 'package:pet_app/widgets/image_tile.dart';

class PetSitterTile extends StatelessWidget {
  final User petSitter;

  const PetSitterTile({Key key, @required this.petSitter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ImageTile(
          imageUrl: petSitter.pictureUrl,
          placeHolder: AssetImage("assets/blank_profile.png"),
        ),
        title: Text(petSitter.username),
        subtitle: Text(petSitter.bio),
        trailing: Icon(
          Icons.chat,
          color: Theme.of(context).primaryColorLight,
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(PetSitterProfilePage.routeName, arguments: petSitter);
        });
  }
}

//leading: petSitter.pictureUrl.isEmpty
//? Image.asset(
//"assets/blank_profile.png",
//)
//: Image.network(
//petSitter.pictureUrl,
//),
//title: Text(petSitter.username),
//subtitle: Text(petSitter.bio),
//trailing: new IconButton(
//icon: new Icon(Icons.chat),
//onPressed: () async {
//UserService _userService = services.get<UserService>();
//AuthService _authService = services.get<AuthService>();
//User currentUser=await _userService.getUser(_authService.currentUserUid);
//if(!currentUser.conversations.contains(petSitter.uid)){
//currentUser.conversations.add(petSitter.uid);
//}
//_userService.updateUser(currentUser);
//
//Navigator.of(context)
//.pushNamed(ChatPage.routeName, arguments: petSitter.uid);
//},
//));
