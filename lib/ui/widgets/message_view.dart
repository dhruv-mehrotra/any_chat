import 'package:any_chat/models/message.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  const MessageView({Key key, this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.008),
      child: Align(
        alignment: (!message.isSender ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.02),
            color:
                (!message.isSender ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(size.height * 0.015),
          child: Text(
            message.text,
            style: TextStyle(fontSize: size.height * 0.022),
          ),
        ),
      ),
    );
  }
}
