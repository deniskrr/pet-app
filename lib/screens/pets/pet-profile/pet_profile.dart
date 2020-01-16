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
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    displayPetPicture(context),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                                child: Text(
                                  displayedPet.type,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                                child: Text(
                                  displayedPet.age.toString() + ' years old',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                      ),
                      displayPetBiography(),
//                      displayDivider(),
                      displayPetSittingStatus(),
                      displayPetMatingStatus(context),
//                      currentUserId != displayedPet.ownerId
//                          ? buttonsForVisitor(context)
//                          : buttonsForOwner(context)
                    ],
                  ),
                )
              ],
            )));
  }

  actionsForVisitor() {
    return <Widget>[
      if (displayedPet.forPetSitting)
        IconButton(
            padding: EdgeInsets.all(20),
            icon: Icon(Icons.accessibility),
            onPressed: () {}),
      if (displayedPet.forPetMating)
        IconButton(
          padding: EdgeInsets.all(20),
          icon: Icon(Icons.pets),
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
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddEditPetPage.routeName, arguments: displayedPet);
        },
      ),
      IconButton(
          padding: EdgeInsets.all(20),
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return confirmDeleteDialog(context);
                });
          }),
    ];
  }

  Row buttonsForVisitor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (displayedPet.forPetSitting)
          FlatButton(
            onPressed: () => {},
            padding: EdgeInsets.all(10),
            color: Theme.of(context).buttonColor,
            child: Text(
              "Pet-sit",
            ),
          ),
        if (displayedPet.forPetMating)
          FlatButton(
            onPressed: () => {},
            padding: EdgeInsets.all(10),
            color: Theme.of(context).buttonColor,
            child: Text(
              "Mating",
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
          color: Theme.of(context).buttonColor,
          child: Text(
            "Edit",
//            style: TextStyle(color: Colors.white),
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
          color: Theme.of(context).buttonColor,
          child: Text(
            "Delete",
//            style: TextStyle(color: Colors.white),
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
        child: ListTile(
//          title: Text("Bio"),
          title: Text(
            displayedPet.biography,
            style: TextStyle(fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  Align displayPetSittingStatus() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.accessibility_new, color: (displayedPet.forPetSitting ? Colors.black54 : Colors.black26),),
          title: Text(
            "" +
                (displayedPet.forPetSitting
                    ? "I'm looking for a pet sitter!"
                    : "Not looking for pet sitter"),
            style: TextStyle(
                color: (displayedPet.forPetSitting
                    ? Colors.black54
                    : Colors.black26),
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  Align displayPetMatingStatus(context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.pets, color: (displayedPet.forPetMating ? Colors.black54 : Colors.black26),),
          title: Text(
            "" +
                (displayedPet.forPetMating
                    ? "I'm looking for a mating partner!"
                    : "Not looking for mating partner."),
            style: TextStyle(
                color: (displayedPet.forPetMating ? Colors.black54 : Colors.black26),
                ),
            textAlign: TextAlign.start,
          ),
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
        placeholder: AssetImage('assets/blank_pet_profile.png'));
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
        'Are you sure you want to remove this pet?',
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

  displayDivider() {
    return Divider(
      color: Colors.black26,
    );
  }
}


Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;

  /// if [500] is the default color, there are at LEAST five
  /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
  /// divisor of 5 would mean [50] is a lightness of 1.0 or
  /// a color of #ffffff. A value of six would be near white
  /// but not quite.
  final lowDivisor = 6;

  /// if [500] is the default color, there are at LEAST four
  /// steps above [500]. A divisor of 4 would mean [900] is
  /// a lightness of 0.0 or color of #000000
  final highDivisor = 5;

  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}