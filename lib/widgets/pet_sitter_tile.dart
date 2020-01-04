import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';

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
    );
  }
}
