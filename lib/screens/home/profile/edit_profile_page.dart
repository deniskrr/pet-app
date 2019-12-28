import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';

class EditProfilePage extends StatefulWidget {
  static final routeName = '/edit-profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    User currentUser = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(currentUser.pictureUrl),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
          ),
          SizedBox(
            height: 20,
          ),
          Checkbox(
            value: currentUser.isPetSitter,
            onChanged: (newValue) {
              currentUser.isPetSitter = newValue;
            },
          ),
          FlatButton(
            child: Text("Save"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
