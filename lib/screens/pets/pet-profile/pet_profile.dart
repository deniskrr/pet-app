import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/pets/add-edit-pet/add-edit_pet_page.dart';
import 'package:pet_app/screens/pets/my_pets/my_pets_page.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';

class PetProfile extends StatelessWidget {
  final Pet displayedPet;

  const PetProfile({Key key, @required this.displayedPet})
      : assert(displayedPet != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserId = services.get<AuthService>().currentUserUid;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(displayedPet.name),
          actions: currentUserId == displayedPet.ownerId
              ? <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(20),
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddEditPetPage.routeName,
                          arguments: displayedPet);
                    },
                  ),
                  IconButton(
                      padding: EdgeInsets.all(20),
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return confirmDeleteDialog(context);
                            });
                      }),
                ]
              : <Widget>[
                  if (displayedPet.forPetMating)
                    IconButton(
                      padding: EdgeInsets.all(20),
                      icon: Icon(Icons.pets, color: Colors.green),
                      onPressed: () {},
                    ),
                  if (displayedPet.forPetSitting)
                    IconButton(
                        padding: EdgeInsets.all(20),
                        icon: Icon(Icons.accessibility,
                            color: Colors.amberAccent),
                        onPressed: () {}),
                ],
        ),
        body: SafeArea(
            child: Container(
          color: Colors.black.withOpacity(0.9),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  FadeInImage(
                      image: displayedPet.pictureUrl.isEmpty
                          ? AssetImage("assets/blank_pet_profile.png")
                          : NetworkImage(displayedPet.pictureUrl),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      placeholder: AssetImage('assets/blank_pet_profile.jpg')),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.brown.withOpacity(0.9),
                              Colors.brown.withOpacity(0.7),
                              Colors.brown.withOpacity(0.5),
                              Colors.brown.withOpacity(0.3),
                              Colors.brown.withOpacity(0.15),
                              Colors.brown.withOpacity(0.07),
                              Colors.brown.withOpacity(0.05),
                              Colors.brown.withOpacity(0.025),
                            ],
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Container())),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.brown.withOpacity(0.8),
                              Colors.brown.withOpacity(0.6),
                              Colors.brown.withOpacity(0.6),
                              Colors.brown.withOpacity(0.4),
                              Colors.brown.withOpacity(0.07),
                              Colors.brown.withOpacity(0.05),
                              Colors.brown.withOpacity(0.025),
                            ],
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container())),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              child: Text(
                                displayedPet.type,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 22),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                              child: Text(
                                displayedPet.age.toString() + ' years',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 5),
                    )
                  ]),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Biography: ' + displayedPet.biography,
                            style: TextStyle(color: Colors.brown, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Pet-sitting status: " +
                                (displayedPet.forPetSitting
                                    ? "I'm looking for a pet sitter!"
                                    : "I have a pet-sitter for now."),
                            style: TextStyle(
                                color: (displayedPet.forPetSitting
                                    ? Colors.amberAccent
                                    : Colors.white),
                                fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Mating status: " +
                                (displayedPet.forPetMating
                                    ? "I'm looking for a mating partner!"
                                    : "I'm fine now."),
                            style: TextStyle(
                                color: (displayedPet.forPetMating
                                    ? Colors.green
                                    : Colors.white),
                                fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      currentUserId != displayedPet.ownerId
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                if (displayedPet.forPetSitting)
                                  FlatButton(
                                    onPressed: () => {},
                                    padding: EdgeInsets.all(10),
                                    color: Colors.brown,
                                    child: Text(
                                      "Pet-sitting",
                                      style:
                                          TextStyle(color: Colors.amberAccent),
                                    ),
                                  ),
                                if (displayedPet.forPetMating)
                                  FlatButton(
                                    onPressed: () => {},
                                    padding: EdgeInsets.all(10),
                                    color: Colors.brown,
                                    child: Text(
                                      "Mating",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                if (displayedPet.forPetSitting)
                                  FlatButton(
                                    onPressed: () => {
                                      Navigator.of(context).pushNamed(
                                          AddEditPetPage.routeName,
                                          arguments: displayedPet)
                                    },
                                    padding: EdgeInsets.all(10),
                                    color: Colors.brown,
                                    child: Text(
                                      "Edit",
                                      style:
                                          TextStyle(color: Colors.amberAccent),
                                    ),
                                  ),
                                if (displayedPet.forPetMating)
                                  FlatButton(
                                    onPressed: () => {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return confirmDeleteDialog(context);
                                          })
                                    },
                                    padding: EdgeInsets.all(10),
                                    color: Colors.brown,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  )
                              ],
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }

  deletePet(BuildContext context, String petId) async {
    final PetsService petsService = services.get<PetsService>();
    await petsService.deletePet(petId);

    // to be changed. It works partially - back button to previous pet list still works...
    Navigator.of(context).pushNamedAndRemoveUntil(
        MyPetsPage.routeName, ModalRoute.withName(HomePage.routeName));
  }

  AlertDialog confirmDeleteDialog(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Are you sure you want to get it out?',
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No')),
        FlatButton(
            onPressed: () {
              deletePet(context, displayedPet.id);
            },
            child: Text('Yes')),
      ],
    );
  }
}
