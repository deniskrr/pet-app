import 'package:flutter/material.dart';
import 'package:pet_app/widgets/input_field.dart';

class ChatMessageInputField extends StatefulWidget {
  final String myUid;
  final String recipientUid;

  const ChatMessageInputField({Key key, this.myUid, this.recipientUid})
      : super(key: key);

  @override
  _ChatMessageInputFieldState createState() => _ChatMessageInputFieldState();
}

class _ChatMessageInputFieldState extends State<ChatMessageInputField> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InputField(
              controller: messageController,
              hintText: "Type a message",
            ),
          ),
        ),
        Icon(Icons.send)
      ],
    );
  }
}
