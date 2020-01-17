import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/model/pet.dart';
import 'package:pet_app/model/pet_type.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/widgets/drop_down_list.dart';
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
  final AuthService _authService = services.get<AuthService>();

  File _image;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final biographyController = TextEditingController();
  final ageController = TextEditingController();
  static String petType;
  final Function(String) typeController = (String newType){petType = newType;};


  void initPetForm() {
    petObject = ModalRoute.of(context).settings.arguments;
    this.nameController.text = petObject.name;
    this.biographyController.text = petObject.biography;
    this.ageController.text = petObject.age.toString();
    petType = "Animal type";
    if(petObject.type != PetType.NotDefined){
      petType = petObject.petType;
    }
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
    biographyController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isInitialized == false) {
      initPetForm();
      isInitialized = true;
    }

    var classType;
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
              DropDownList(
                onValueSelected: typeController,
                hintText: petType,
              )
            ,
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
                        "Please, make sure that the inputs are in the correct format!");
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
    petObject.petType = petType;
    petObject.biography = biographyController.text;

    try {
      petObject.age = int.parse(ageController.text);
    } catch (error) {
      AppDialogs.showAlertDialog(context, "Invalid input", "The age must be a number!");
      return;
    }

    if (_image != null)
      await _storageService.uploadPhoto(_image).then((pictureUrl) {
        petObject.pictureUrl = pictureUrl;
      });

    widget.petActionHandler(petObject);
  }
}
