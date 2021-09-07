import 'package:any_chat/enum/view_state.dart';
import 'package:any_chat/models/message.dart';
import 'package:any_chat/ui/views/base_view.dart';
import 'package:any_chat/ui/widgets/message_view.dart';
import 'package:any_chat/viewmodels/chat_page_model.dart';
import 'package:flutter/material.dart';

class ChatPageView extends StatefulWidget {
  const ChatPageView({Key key}) : super(key: key);

  @override
  _ChatPageViewState createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  Widget chatBox(ChatPageModel model) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(hintText: "Type Message..."),
              controller: model.controller,
              focusNode: model.focusNode,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                model.sendMessage(
                    Message(text: model.controller.text, isSender: true));
                model.controller.text = "";
              },
              child: Icon(Icons.send))
        ],
      ),
    );
  }

  Widget exitButton(Function exit) {
    return ElevatedButton(
      onPressed: exit,
      child: Text('Exit Chat'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseView<ChatPageModel>(
        onModelDestroyed: (model) => model.onModelDestroyed(),
        onModelReady: (model) => model.onModelReady(),
        builder: (context, model, child) {
          model.context = context;
          return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Chat Room'),
                  actions: [exitButton(model.exitChat)]),
              body: ((model.state == ViewState.Waiting) |
                      (model.state == ViewState.Busy))
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text(model.state == ViewState.Waiting
                            ? 'Finding a stranger'
                            : '')
                      ],
                    ))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02),
                                itemCount: model.messages.length,
                                itemBuilder: (context, index) {
                                  return MessageView(
                                      message: model.messages[
                                          model.messages.length - 1 - index]);
                                })),
                        chatBox(model),
                        Text(
                          model.strangerTyping ? "Typing..." : "",
                        )
                      ],
                    ));
        });
  }
}
