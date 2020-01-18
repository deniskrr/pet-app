import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';

import 'chat_list_view.dart';

class ChatsOverviewPage extends StatefulWidget {
  @override
  _ChatsOverviewPageState createState() => _ChatsOverviewPageState();
}

class _ChatsOverviewPageState extends State<ChatsOverviewPage> {
  ChatService _chatService = services.get<ChatService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _chatService.getChattedUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data;
            return Flex(
              direction: Axis.vertical,
              children: [
                ChatListView(
                  userList: users,
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
