import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/helpers/app_dialogs.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/services/user/user_service.dart';
import 'package:pet_app/widgets/input_field.dart';
import 'package:pet_app/widgets/labeled_checkbox.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final StorageService _storageService = services.get<StorageService>();
  final UserService _userService = services.get<UserService>();
  File _image;
  final _formKey = GlobalKey<FormState>();
  final biographyController = TextEditingController();

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
    biographyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = ModalRoute.of(context).settings.arguments;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            ProfilePicture(
                image: _image,
                pictureUrl: currentUser.pictureUrl,
                placeholderImageUri: "assets/blank_profile.png",
                imageGetter: getImage),
            InputField(
              controller: biographyController,
              hintText: "Biography",
            ),
            LabeledCheckbox(
              label: "Are you a petsitter?",
              value: currentUser.isPetSitter,
              valueHandler: (newValue) {
                setState(() {
                  currentUser.isPetSitter = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: "Do you provide services for pets?",
              value: currentUser.isServiceProvider,
              valueHandler: (newValue) {
                setState(() {
                  currentUser.isServiceProvider = newValue;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    updateInfo(currentUser, _image, biographyController.text);
                  } else
                    AppDialogs.showAlertDialog(context, "Operation failed",
                        "Please, make sure that the inputs are in the correct format!");
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateInfo(User user, File picture, String bio) {
    user.bio = bio;
    if (_image != null) {
      _storageService.uploadPhoto(_image).then((pictureUrl) {
        user.pictureUrl = pictureUrl;
        _userService
            .updateUser(user)
            .whenComplete(() => Navigator.of(context).pop());
      });
    } else {
      _userService
          .updateUser(user)
          .whenComplete(() => Navigator.of(context).pop());
    }
  }
}
