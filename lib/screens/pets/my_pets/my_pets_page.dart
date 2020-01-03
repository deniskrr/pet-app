import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/widgets/pet_list_view.dart';

class MyPetsPage extends StatelessWidget {
  static final routeName = '/my-pets';
  final PetsService _petsService = services.get<PetsService>();
  final AuthService _authService = services.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _petsService.getPetsForOwnerId(_authService.currentUserUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pet> pets = snapshot.data;
            return PetListView(
              petList: pets,
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
