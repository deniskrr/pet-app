import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';

class ChatTile extends StatelessWidget {
  final User user;

  const ChatTile({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatService _chatService = services.get<ChatService>();
    return ListTile(
      leading: user.pictureUrl.isEmpty
          ? Image.asset(
              "assets/blank_profile.png",
            )
          : Image.network(
              user.pictureUrl,
            ),
      title: Text(user.username),
      subtitle: FutureBuilder(
        future: _chatService.getFirstMessage(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          }
          return Text("");
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.chat,
              color: Theme.of(context).primaryColorLight
//              color: Color(0xFFB9E5E4)
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(ChatPage.routeName, arguments: user);
      },
    );
  }
}
