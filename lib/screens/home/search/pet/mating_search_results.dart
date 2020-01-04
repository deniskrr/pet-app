import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/widgets/pet_list_view.dart';

class MatingSearchResults extends StatelessWidget {
  final Pet forPet;
  final PetsService _petsService = services.get<PetsService>();
  final AuthService _authService = services.get<AuthService>();

  MatingSearchResults({@required this.forPet});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _petsService.getMatingCompanionsForType(forPet.type),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pet> pets = snapshot.data;
          pets.removeWhere(
              (Pet pet) => pet.ownerId == _authService.currentUserUid);
          return PetListView(
            petList: pets,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
