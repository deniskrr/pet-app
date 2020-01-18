import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class PetSitterProfilePage extends StatelessWidget {
  static final routeName = '/pet-sitter-profile';
  User petSitter;

  @override
  Widget build(BuildContext context) {
    petSitter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet sitter'),
      ),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(children: <Widget>[
              ProfilePicture(
                pictureUrl: petSitter.pictureUrl,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(petSitter.bio),
              ),
              SizedBox(
                height: 50,
              ),
            ]),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Chat"),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            )
          ],
        ),
      ),
    );
  }
}
