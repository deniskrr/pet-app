import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';

class ChatTile extends StatelessWidget {
  final User user;

  const ChatTile({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: user.pictureUrl.isEmpty
          ? Image.asset(
        "assets/blank_chat_profile.png",
      )
          : Image.network(
        user.pictureUrl,
      ),
      title: Text(user.username),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           Icon(Icons.chat),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(ChatPage.routeName, arguments: user.uid);
      },
    );
  }
}
