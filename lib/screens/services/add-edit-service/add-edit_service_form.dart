import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/model/pet_type.dart';
import 'package:pet_app/model/service.dart';
import 'package:pet_app/model/service_category.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/widgets/drop_down_list.dart';
import 'package:pet_app/widgets/input_field.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class AddEditServiceForm extends StatefulWidget {
  final Function(Service) addServiceHandler;

  const AddEditServiceForm({Key key, this.addServiceHandler}) : super(key: key);

  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddEditServiceForm> {
  Service serviceObject;
  bool isInitialized = false;

  final StorageService _storageService = services.get<StorageService>();
  final AuthService _authService = services.get<AuthService>();

  File _image;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();

  static String petType;
  static String serviceCategory;

  final Function(String) typeController = (String newType) {
    petType = newType;
  };

  final Function(String) categoryController = (String newCategory) {
    serviceCategory = newCategory;
  };

  void initServiceForm() {
    serviceObject = ModalRoute.of(context).settings.arguments;
    this.nameController.text = serviceObject.name;
    this.descriptionController.text = serviceObject.description;
    this.addressController.text = serviceObject.address;

    petType = "Animal Type";
    serviceCategory = "Service Category";

    if (serviceObject.petType != PetType.NotDefined) {
      petType = serviceObject.servicePetType;
    }

    if (serviceObject.category != ServiceCategory.NotDefined) {
      serviceCategory = serviceObject.serviceCategory;
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
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isInitialized == false) {
      initServiceForm();
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
                pictureUrl: serviceObject.pictureUrl,
                placeholderImageUri: "assets/blank_services.png",
                imageGetter: getImage),
            InputField(
              controller: nameController,
              hintText: "Name",
            ),
            SizedBox(
              height: 10,
            ),
            DropDownList(
              onValueSelected: typeController,
              hintText: petType,
              givenEnumClass: "PetType",
            ),
            SizedBox(
              height: 10,
            ),
            DropDownList(
              onValueSelected: categoryController,
              hintText: serviceCategory,
              givenEnumClass: "ServiceCategory",
            ),
            InputField(
              controller: descriptionController,
              hintText: "Description",
            ),
            InputField(
              controller: addressController,
              hintText: "Address",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    addService(serviceObject);
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
    serviceObject.description = descriptionController.text;
    serviceObject.address = addressController.text;
    serviceObject.servicePetType = petType;
    serviceObject.serviceCategory = serviceCategory;

    if (_image != null)
      await _storageService.uploadPhoto(_image).then((pictureUrl) {
        serviceObject.pictureUrl = pictureUrl;
      });

    widget.addServiceHandler(serviceObject);
  }
}
