import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
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
                image: null,
                pictureUrl: petSitter.pictureUrl,
                placeholderImageUri: "assets/blank_profile.png",
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(petSitter.username,
                        style: TextStyle(fontSize: 16)),
                  )),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          title: Text(
                        petSitter.bio,
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.start,
                      )),
                    ),
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        leading: Icon(Icons.accessibility_new),
                        title: Text("I am available for pet sitting!"),
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        leading: Icon(Icons.chat),
                        title: Text("Write me a message!"),
                      )))
            ]),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(ChatPage.routeName, arguments: petSitter.uid),
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
