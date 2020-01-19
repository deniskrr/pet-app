import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/widgets/profile_picture.dart';

class PetSitterProfilePage extends StatelessWidget {
  static final routeName = '/pet-sitter-profile';
  User petSitter;
  final _chatService = services.get<ChatService>();

  @override
  Widget build(BuildContext context) {
    petSitter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(petSitter.username),
        actions: actions(context)
      ),
      resizeToAvoidBottomPadding: true,
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(children: <Widget>[
            Stack(
              children: <Widget>[
                FadeInImage(
                image: petSitter.pictureUrl.isEmpty
                    ? AssetImage("assets/blank_profile.png")
                      : NetworkImage(petSitter.pictureUrl),
                height: 300,
                width: MediaQuery.of(context).size.width,
                placeholder: AssetImage('assets/blank_profile.png')),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Color(0x86FCBA94),
                      child: ListTile(
                        title: Text(
                          petSitter.username,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 22),
                        ),
                        subtitle: Text(
                          'Pet Sitter',
//                                  textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
//            RaisedButton(
//              onPressed: () => Navigator.of(context).pushNamed(ChatPage.routeName, arguments: petSitter),
//              child: Text("Chat"),
//            ),
//            SizedBox(
//              height: 10,
//            ),
//            FlatButton(
//              onPressed: () => Navigator.of(context).pop(),
//              child: Text("Cancel"),
//            )
              ],
            ),
          ),
        ],
      ),
    );
  }


  actions(BuildContext context) {
    return <Widget>[
      IconButton(
        padding: EdgeInsets.all(20),
        icon: Icon(Icons.chat),
        onPressed: () {
          _chatService.sendMessage(petSitter.uid, "Hi, ${petSitter.username}! I need a pet sitter. Are you interested?");
          Navigator.of(context)
              .pushNamed(ChatPage.routeName, arguments: petSitter);
        },
      ),
      ];
  }
}
