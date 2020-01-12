import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/screens/home/search/pet/mating_search_results.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';

class PetSearchPage extends StatefulWidget {
  @override
  _PetSearchPageState createState() => _PetSearchPageState();
}

class _PetSearchPageState extends State<PetSearchPage> {
  final PetsService _petsService = services.get<PetsService>();
  final AuthService _authService = services.get<AuthService>();
  Pet _selectedPet;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _petsService.getMatingPetsForOwnerId(_authService.currentUserUid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pet> pets = snapshot.data;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<Pet>(
                  hint: Text("Mating partner for:"),
                  items: pets
                      .map(
                        (Pet pet) =>
                        DropdownMenuItem(
                          value: pet,
                          child: Text(pet.name),
                        ),
                  )
                      .toList(),
                  onChanged: (pet) {
                    setState(() {
                      _selectedPet = pet;
                    });
                  },
                  value: _selectedPet,
                ),
                SizedBox(
                  height: 16,
                ),
                if (_selectedPet != null)
                  MatingSearchResults(forPet: _selectedPet),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
