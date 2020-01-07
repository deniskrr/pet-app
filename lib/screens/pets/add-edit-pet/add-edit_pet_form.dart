import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/widgets/input_field.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class AddEditPetForm extends StatefulWidget {
  final Function(Pet) petActionHandler;

  const AddEditPetForm({Key key, this.petActionHandler}) : super(key: key);

  @override
  _AddEditPetFormState createState() => _AddEditPetFormState();
}

class _AddEditPetFormState extends State<AddEditPetForm> {
  Pet petObject;

  final StorageService _storageService = services.get<StorageService>();
  final AuthService _authService = services.get<AuthService>();

  File _image;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final biographyController = TextEditingController();
  final ageController = TextEditingController();

  void initFormFields() {
    this.nameController.text = petObject.name;
    this.typeController.text = petObject.type;
    this.biographyController.text = petObject.biography;
    this.ageController.text = petObject.age.toString();
  }

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
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    petObject = ModalRoute.of(context).settings.arguments;
    initFormFields();

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            ProfilePicture(
                image: _image,
                pictureUrl: petObject.pictureUrl,
                placeholderImageUri: "assets/blank_pet_profile.png",
                imageGetter: getImage),
            InputField(
              controller: nameController,
              hintText: "Name",
            ),
            InputField(
              controller: typeController,
              hintText: "Type e.g. 'Dog'",
            ),
            InputField(
              controller: biographyController,
              hintText: "Biography",
            ),
            InputField(
              controller: ageController,
              hintText: "Age",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Needs to be pet-sitted'),
                Checkbox(
                  value: petObject.forPetSitting,
                  onChanged: (newVal) {
                    setState(() {
                      petObject.forPetSitting = newVal; // entire form is influenced on this. I don't know why ?!
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Available for pet mating'),
                Checkbox(
                  value: petObject.forPetMating,
                  onChanged: (newVal) {
                    setState(() {
                      petObject.forPetMating = newVal; // entire form is influenced on this. I don't know why ?!
                    });
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (petObject.id.compareTo("") == 0) {
                      addPet(petObject);
                    } else {
                      updatePet(petObject);
                    }
                  } else
                    AppDialogs.showAlertDialog(context, "Operation failed",
                        "Please, make sure that the inputs are in the correct format!");
                },
                child:
                    petObject.id == "" ? Text('Add Pet') : Text('Upgrade Pet'),
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
    widget.petActionHandler(petObject);
  }

  void updatePet(Pet petObject) {
    petObject.name = nameController.text;
    petObject.type = typeController.text;
    petObject.biography = biographyController.text;
    petObject.age = int.parse(ageController.text);

    // should we delete the previous image?..

    _storageService.uploadPhoto(_image).then((pictureUrl) {
      petObject.pictureUrl = pictureUrl;
      //widget.addPetHandler(petObject);
    });
    widget.petActionHandler(petObject);
  }
}
