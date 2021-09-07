import 'package:any_chat/enum/view_state.dart';
import 'package:any_chat/ui/views/base_view.dart';
import 'package:any_chat/ui/views/chat_view.dart';
import 'package:any_chat/viewmodels/home_page_model.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomePageModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(title: Text('Welcome to Any Chat')),
        body: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : Center(
                child: Column(
                  children: [
                    Text(model.justDisconnected
                        ? "Stranger left the chat!"
                        : ""),
                    ElevatedButton(
                      child: Text('Start chatting!'),
                      onPressed: () {
                        model.setState(ViewState.Busy);
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => ChatPageView()))
                            .then((value) {
                          model.notifyListeners();
                          return;
                        });
                        model.setState(ViewState.Idle);
                      },
                    ),
                    Text(model.state == ViewState.Error
                        ? "Couldn't connect to server"
                        : "")
                  ],
                ),
              ),
      );
    });
  }
}
