import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/widgets/pet_tile.dart';

class PetListView extends StatelessWidget {
  final List<Pet> petList;

  const PetListView({Key key, this.petList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black12,
        ),
        itemCount: petList.length,
        itemBuilder: (context, index) {
          Pet currentPet = petList[index];
          return PetTile(
            pet: currentPet,
          );
        },
      ),
    );
  }
}
