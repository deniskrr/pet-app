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
import 'package:pet_app/widgets/profile_picture.dart';

class AddEditPetForm extends StatefulWidget {
  final Function(Pet) petActionHandler;

  const AddEditPetForm({Key key, this.petActionHandler}) : super(key: key);

  @override
  _AddEditPetFormState createState() => _AddEditPetFormState();
}

class _AddEditPetFormState extends State<AddEditPetForm> {
  Pet petObject;
  bool isInitialized = false;

  final StorageService _storageService = services.get<StorageService>();
  final PetsService _petsService = services.get<PetsService>();
  final AuthService _authService = services.get<AuthService>();

  File _image;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final biographyController = TextEditingController();
  final ageController = TextEditingController();

  void initPetForm() {
    petObject = ModalRoute.of(context).settings.arguments;
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
    if(isInitialized == false){
      initPetForm();
      isInitialized = true;
    }

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
              hintText: "About",
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
                      petObject.forPetSitting = newVal;
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
                      petObject.forPetMating = newVal;
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
                    addOrEditPet(petObject);
                  } else
                    AppDialogs.showAlertDialog(context, "Operation failed",
                        "Please make sure that the inputs are in the correct format!");
                },
                child:
                    petObject.id.isEmpty ? Text('Add Pet') : Text('Update Pet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addOrEditPet(Pet petObject) async {
    petObject.ownerId = _authService.currentUserUid;
    petObject.name = nameController.text;
    petObject.type = typeController.text;
    petObject.biography = biographyController.text;
    petObject.age = int.parse(ageController.text);

    if (_image != null)
      await _storageService.uploadPhoto(_image).then((pictureUrl) {
        petObject.pictureUrl = pictureUrl;
      });

    widget.petActionHandler(petObject);
  }
}
