import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_page.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/widgets/image_tile.dart';

String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('HH:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }

  return time;
}

class ChatTile extends StatelessWidget {
  final User user;

  const ChatTile({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatService _chatService = services.get<ChatService>();
    return ListTile(
      leading: ImageTile(
        imageUrl: user.pictureUrl,
        placeHolder: AssetImage("assets/blank_profile.png"),
      ),
      title: Text(user.username),
      subtitle: FutureBuilder(
        future: _chatService.getFirstMessage(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final ChatMessage message = snapshot.data;
            String toReturn = "";
            if (message.sentByMe)
              toReturn = "You: ";
            else
              toReturn = "Other: ";

            if (message.message.length > 20)
              toReturn += message.message.substring(0, 20) + "...";
            else
              toReturn += message.message;

            toReturn += "\n" + readTimestamp(message.dateSent.seconds);

            return Text(toReturn);
          }
          return Text("");
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.chat, color: Theme.of(context).primaryColorLight
//              color: Color(0xFFB9E5E4)
              ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(ChatPage.routeName, arguments: user);
      },
    );
  }
}
