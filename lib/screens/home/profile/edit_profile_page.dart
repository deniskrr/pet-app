import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/services/user/user_service.dart';

class EditProfilePage extends StatefulWidget {
  static final routeName = '/edit-profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image;
  final StorageService _storageService = services.get<StorageService>();
  final UserService _userService = services.get<UserService>();
  final bioController = TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
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

  @override
  Widget build(BuildContext context) {
    User currentUser = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: _image == null
                      ? (currentUser.pictureUrl.isEmpty
                      ? AssetImage(
                    "assets/blank_profile.png",
                  )
                      : NetworkImage(
                    currentUser.pictureUrl,
                  ))
                      : FileImage(
                    _image,
                  ),
                ),
                onTap: () => getImage(),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: bioController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: currentUser.isPetSitter,
                    onChanged: (newValue) {
                      setState(() {
                        currentUser.isPetSitter = newValue;
                      });
                    },
                  ),
                  Text("Pet sitter")
                ],
              ),
              FlatButton(
                child: Text("Save"),
                onPressed: () {
                  updateInfo(currentUser, _image, bioController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
