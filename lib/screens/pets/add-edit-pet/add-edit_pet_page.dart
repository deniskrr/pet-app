import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/pets/add-edit-pet/add-edit_pet_form.dart';
import 'package:pet_app/screens/pets/my_pets/my_pets_page.dart';
import 'package:pet_app/screens/pets/pet-profile/pet_profile.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';

class AddEditPetPage extends StatefulWidget {
  static final routeName = '/add-pet';

  @override
  _AddEditPetPageState createState() => _AddEditPetPageState();
}

class _AddEditPetPageState extends State<AddEditPetPage> {
  final PetsService _petsService = services.get<PetsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Pet"),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AddEditPetForm(
                  petActionHandler: (Pet petObject) async {
                    if (petObject.id.isEmpty) {
                      await _petsService.addPet(petObject).then((_) =>

                          // needs to be changed. Routing doesn't work fine
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              MyPetsPage.routeName,
                              ModalRoute.withName(HomePage.routeName)));
                    } else {
                      await _petsService.updatePet(petObject).then(
                          (updatedPet) =>

                              // needs to be changed. Routing doesn't work fine
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => new PetProfile(
                                          displayedPet: updatedPet))));
                    }
                  },
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                )
              ],
            ),
          ),
        )));
  }
}
