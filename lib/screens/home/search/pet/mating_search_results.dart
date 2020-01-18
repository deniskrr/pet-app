import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/widgets/no_match_search.dart';
import 'package:pet_app/widgets/pet_list_view.dart';

class MatingSearchResults extends StatelessWidget {
  final Pet forPet;
  final PetsService _petsService = services.get<PetsService>();

  MatingSearchResults({@required this.forPet});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _petsService.getMatingCompanionsForType(forPet.petType),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pet> pets = snapshot.data;
          if (pets.isNotEmpty)
            return PetListView(
              petList: pets,
            );
          else
            return NoMatchSearch();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
