import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';

import 'chat_tile.dart';

class ChatListView extends StatelessWidget {
  final List<User> userList;

  const ChatListView({Key key, this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black12,
        ),
        itemCount: userList.length,
        itemBuilder: (context, index) {
          User currentChat = userList[index];
          return ChatTile(
            user: currentChat,
          );
        },
      ),
    );
  }
}
