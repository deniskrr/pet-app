import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/pet-sitter/pet_sitter_profile_page.dart';

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
      trailing: Icon(Icons.chat),
      onTap:(){
        Navigator.of(context).pushNamed(
          PetSitterProfilePage.routeName,
          arguments: petSitter
        );
      }
    );
  }
}
