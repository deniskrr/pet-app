import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/screens/pets/pet-profile/pet_profile.dart';
import 'package:pet_app/widgets/image_tile.dart';

class PetTile extends StatelessWidget {
  final Pet pet;

  const PetTile({Key key, @required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageTile(
        imageUrl: pet.pictureUrl,
        placeHolder: AssetImage("assets/blank_pet_profile.png"),
      ),
      title: Text(pet.name),
      subtitle: Text(pet.petType),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (pet.forPetSitting) Icon(Icons.accessibility),
          if (pet.forPetMating) Icon(Icons.pets),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(PetProfile.routeName, arguments: pet);
      },
    );
  }
}
