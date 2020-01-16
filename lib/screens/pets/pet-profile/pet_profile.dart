import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/home_page.dart';
import 'package:pet_app/screens/pets/add-edit-pet/add-edit_pet_page.dart';
import 'package:pet_app/screens/pets/my_pets/my_pets_page.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';

class PetProfile extends StatelessWidget {
  static final String routeName = '/pet-profile';
  Pet displayedPet;

  @override
  Widget build(BuildContext context) {
    displayedPet = ModalRoute.of(context).settings.arguments;

    final currentUserId = services.get<AuthService>().currentUserUid;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(displayedPet.name),
          actions: currentUserId == displayedPet.ownerId
              ? actionsForOwner(context)
              : actionsForVisitor(),
        ),
        body: SafeArea(
            child: Container(
          color: Colors.black.withOpacity(0.9),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  displayPetPicture(context),
                  backgroundAlignForImage(Colors.brown, Alignment.topCenter,
                      Alignment.bottomCenter, 100, 1),
                  backgroundAlignForImage(Colors.brown, Alignment.bottomCenter,
                      Alignment.topCenter, 300, 8),
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
                      displayPetBiography(),
                      displayPetSittingStatus(),
                      displayPetMatingStatus(),
                      currentUserId != displayedPet.ownerId
                          ? buttonsForVisitor()
                          : buttonsForOwner(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }

  actionsForVisitor() {
    return <Widget>[
      if (displayedPet.forPetSitting)
        IconButton(
            padding: EdgeInsets.all(20),
            icon: Icon(Icons.accessibility, color: Colors.amberAccent),
            onPressed: () {}),
      if (displayedPet.forPetMating)
        IconButton(
          padding: EdgeInsets.all(20),
          icon: Icon(Icons.pets, color: Colors.green),
          onPressed: () {},
        ),
      Padding(
          padding: const EdgeInsets.all(7),
          child: Container(
              alignment: Alignment.center, child: petOwnerProfilePicture()))
    ];
  }

  actionsForOwner(BuildContext context) {
    return <Widget>[
      IconButton(
        padding: EdgeInsets.all(20),
        icon: Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddEditPetPage.routeName, arguments: displayedPet);
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
    ];
  }

  Row buttonsForVisitor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (displayedPet.forPetSitting)
          FlatButton(
            onPressed: () => {},
            padding: EdgeInsets.all(10),
            color: Colors.brown,
            child: Text(
              "Pet-sitting",
              style: TextStyle(color: Colors.amberAccent),
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
    );
  }

  Row buttonsForOwner(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () => {
            Navigator.of(context)
                .pushNamed(AddEditPetPage.routeName, arguments: displayedPet)
          },
          padding: EdgeInsets.all(10),
          color: Colors.brown,
          child: Text(
            "Edit",
            style: TextStyle(color: Colors.white),
          ),
        ),
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
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  backgroundAlignForImage(MaterialColor color, Alignment beginAlign,
      Alignment endAlign, double height, double topPadding) {
    return Align(
      alignment: beginAlign,
      child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: beginAlign,
              end: endAlign,
              colors: [
                color.withOpacity(0.8),
                color.withOpacity(0.7),
                color.withOpacity(0.6),
                color.withOpacity(0.5),
                color.withOpacity(0.4),
                color.withOpacity(0.3),
                color.withOpacity(0.2),
                color.withOpacity(0.1),
                color.withOpacity(0.05),
                color.withOpacity(0.025),
              ],
            ),
          ),
          child: Padding(
              padding: EdgeInsets.only(top: topPadding), child: Container())),
    );
  }

  Align displayPetBiography() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Biography: ' + displayedPet.biography,
          style: TextStyle(color: Colors.brown, fontSize: 18),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Align displayPetSittingStatus() {
    return Align(
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
    );
  }

  Align displayPetMatingStatus() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Mating status: " +
              (displayedPet.forPetMating
                  ? "I'm looking for a mating partner!"
                  : "I'm fine now."),
          style: TextStyle(
              color: (displayedPet.forPetMating ? Colors.green : Colors.white),
              fontSize: 18),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  FadeInImage displayPetPicture(BuildContext context) {
    return FadeInImage(
        image: displayedPet.pictureUrl.isEmpty
            ? AssetImage("assets/blank_pet_profile.png")
            : NetworkImage(displayedPet.pictureUrl),
        height: 300,
        width: MediaQuery.of(context).size.width,
        placeholder: AssetImage('assets/blank_pet_profile.jpg'));
  }

  petOwnerProfilePicture() {
    return FutureBuilder<User>(
        future: services.get<UserService>().getUser(displayedPet.ownerId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final User owner = snapshot.data;
            return GestureDetector(
                child: CircleAvatar(
                    minRadius: 20,
                    backgroundImage: owner.pictureUrl.isNotEmpty
                        ? NetworkImage(owner.pictureUrl)
                        : AssetImage('assets/blank_profile.png')),
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      HomePage
                          .routeName); // must be changed in order to redirect to the owner's profile
                });
          }
          return CircleAvatar(
              minRadius: 20,
              backgroundImage: AssetImage('assets/blank_profile.png'));
        });
  }

  deletePet(BuildContext context, String petId) async {
    final PetsService petsService = services.get<PetsService>();
    await petsService.deletePet(petId);
    Navigator.pushNamedAndRemoveUntil(
        context, MyPetsPage.routeName, ModalRoute.withName(HomePage.routeName));
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
