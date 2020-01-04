import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';

class PetTile extends StatelessWidget {
  final Pet pet;

  const PetTile({Key key, @required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: pet.pictureUrl.isEmpty
          ? Image.asset(
              "assets/blank_pet_profile.png",
            )
          : Image.network(
              pet.pictureUrl,
            ),
      title: Text(pet.name),
      subtitle: Text(pet.type),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (pet.forPetSitting) Icon(Icons.accessibility),
          if (pet.forPetMating) Icon(Icons.pets),
        ],
      ),
    );
  }
}
