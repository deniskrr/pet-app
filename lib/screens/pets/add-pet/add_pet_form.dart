import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/pets/pets_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/widgets/input_field.dart';
import 'package:pet_app/widgets/labeled_checkbox.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class AddPetForm extends StatefulWidget {
  final Function(Pet) addPetHandler;

  const AddPetForm({Key key, this.addPetHandler}) : super(key: key);

  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final StorageService _storageService = services.get<StorageService>();
  final PetsService _petsService = services.get<PetsService>();
  final AuthService _authService = services.get<AuthService>();
  File _image;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final biographyController = TextEditingController();
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
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Pet pet = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            ProfilePicture(
                image: _image,
                pictureUrl: pet.pictureUrl,
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
            LabeledCheckbox(
              label: "Visible for pet sitters",
              value: pet.forPetSitting,
              valueHandler: (newValue) {
                setState(() {
                  pet.forPetSitting = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: "Available for pet mating",
              value: pet.forPetMating,
              valueHandler: (newValue) {
                setState(() {
                  pet.forPetMating = newValue;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    addPet(pet);
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

  void addPet(Pet petObject) async {
    petObject.ownerId = _authService.currentUserUid;
    petObject.name = nameController.text;
    petObject.type = typeController.text;
    petObject.biography = biographyController.text;
    petObject.age = int.parse(ageController.text);

    if (_image != null)
      await _storageService.uploadPhoto(_image).then((pictureUrl) {
        petObject.pictureUrl = pictureUrl;
      });

    widget.addPetHandler(petObject);
  }
}
