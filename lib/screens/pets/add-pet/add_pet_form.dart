import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/helpers/app_reusable_widgets.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';

class AddPetForm extends StatefulWidget {
  final Function(Pet) addPetHandler;

  const AddPetForm({Key key, this.addPetHandler}) : super(key: key);

  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final StorageService _storageService = services.get<StorageService>();
  final AuthService _authService = services.get<AuthService>();
  File _image;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final biographyController = TextEditingController();
  final pictureUrlController = TextEditingController();
  final ageController = TextEditingController();

  Future getImage() async {
    final imageSource = await AppDialogs.chooseImageSource(context);

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() => _image = file);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    biographyController.dispose();
    pictureUrlController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Pet petObject = ModalRoute.of(context).settings.arguments;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            AppReusableWidgets.profilePicture(_image, petObject.pictureUrl,
                "assets/blank_pet_profile.png", getImage),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
            ),
            TextFormField(
              controller: typeController,
              decoration: InputDecoration(
                hintText: "Type e.g. 'Dog'",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
            ),
            TextFormField(
              controller: biographyController,
              decoration: InputDecoration(
                  hintText: "Biography",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintMaxLines: 4),
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                  hintText: "Age",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  hintMaxLines: 4),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text("Visible for pet sitters", style: TextStyle(fontSize: 16)),
              Checkbox(
                  value: petObject.forPetSitting,
                  onChanged: (bool val) =>
                      setState(() => petObject.forPetSitting = val)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text("Available for pet mating", style: TextStyle(fontSize: 16)),
              Checkbox(
                  value: petObject.forPetMating,
                  onChanged: (bool val) =>
                      setState(() => petObject.forPetMating = val)),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    addPet(petObject);
                  } else
                    AppDialogs.showAlertDialog(context, "Operation failed",
                        "Please, make sure that the inputs are in the correct format!");
                },
                child: Text('Add Pet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPet(Pet petObject) {
    petObject.ownerId = _authService.currentUserUid;
    petObject.name = nameController.text;
    petObject.type = typeController.text;
    petObject.biography = biographyController.text;
    petObject.age = int.parse(ageController.text);
    _storageService.uploadPhoto(_image).then((pictureUrl) {
      petObject.pictureUrl = pictureUrl;
      //widget.addPetHandler(petObject);
    });
    widget.addPetHandler(petObject);
  }
}
