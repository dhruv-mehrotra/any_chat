import 'package:any_chat/models/message.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  const MessageView({Key key, this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          message.isSender ? 'You' : 'Stranger',
        ),
        Text(
          message.text,
        )
      ],
    );
  }
}
