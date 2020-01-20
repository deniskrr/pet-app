import 'package:flutter/material.dart';
import 'package:pet_app/widgets/input_field.dart';

class ChatMessageInputField extends StatefulWidget {
  final String recipientUid;
  final void Function(String, String) sendMessageFunction;

  const ChatMessageInputField(
      {Key key, this.recipientUid, this.sendMessageFunction})
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
        IconButton(
          icon: Icon(Icons.send,
          color: Theme.of(context).accentColor,),
          onPressed: () {
            final message = messageController.text;
            if (message.isNotEmpty) {
              messageController.clear();
              widget.sendMessageFunction(widget.recipientUid, message);
            }
          },
        ),
      ],
    );
  }
}
