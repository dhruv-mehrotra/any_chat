import 'package:any_chat/enum/view_state.dart';
import 'package:any_chat/ui/views/base_view.dart';
import 'package:any_chat/ui/widgets/message_view.dart';
import 'package:any_chat/viewmodels/chat_page_model.dart';
import 'package:flutter/material.dart';

class ChatPageView extends StatelessWidget {
  const ChatPageView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: BaseView<ChatPageModel>(
          onModelDestroyed: (model) => model.onModelDestroyed(),
          onModelReady: (model) => model.onModelReady(),
          builder: (context, model, child) {
            return (model.state == ViewState.Busy)
                ? CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: model.messages.length,
                              itemBuilder: (context, index) {
                                return MessageView(
                                    message: model.messages[index]);
                              })),
                    ],
                  );
          }),
    );
  }
}
