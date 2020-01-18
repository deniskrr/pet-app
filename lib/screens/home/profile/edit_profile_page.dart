import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/profile/edit_profile_form.dart';

class EditProfilePage extends StatefulWidget {
  static final routeName = '/edit-profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit info"),
      ),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                EditProfileForm(),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
