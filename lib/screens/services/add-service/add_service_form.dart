import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/services/services/services_service.dart';
import 'package:pet_app/widgets/input_field.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class AddServiceForm extends StatefulWidget {
  final Function(Service) addServiceHandler;

  const AddServiceForm({Key key, this.addServiceHandler}) : super(key: key);

  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  final StorageService _storageService = services.get<StorageService>();
  final ServicesService _serviceService = services.get<ServicesService>();
  final AuthService _authService = services.get<AuthService>();
  File _image;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final petTypeController = TextEditingController();

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
    categoryController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    petTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Service service = ModalRoute
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
                pictureUrl: service.pictureUrl,
                placeholderImageUri: "assets/blank_profile.png",
                imageGetter: getImage),
            InputField(
              controller: nameController,
              hintText: "Name",
            ),
            InputField(
              controller: categoryController,
              hintText: "Category e.g. 'Saloon', 'Clinic'",
            ),
            InputField(
              controller: descriptionController,
              hintText: "Description",
            ),
            InputField(
              controller: addressController,
              hintText: "Address",
            ),
            InputField(
              controller: petTypeController,
              hintText: "Animal Type e.g. 'Dog'",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    addService(service);
                  } else
                    AppDialogs.showAlertDialog(context, "Operation failed",
                        "Please, make sure that the inputs are in the correct format!");
                },
                child: Text('Add Service'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addService(Service serviceObject) async {
    serviceObject.ownerId = _authService.currentUserUid;
    serviceObject.name = nameController.text;
    serviceObject.category = categoryController.text;
    serviceObject.description = descriptionController.text;
    serviceObject.address = addressController.text;
    serviceObject.petType = petTypeController.text;

    if (_image != null)
      await _storageService.uploadPhoto(_image).then((pictureUrl) {
        serviceObject.pictureUrl = pictureUrl;
      });

    widget.addServiceHandler(serviceObject);
  }
}
