import 'dart:convert';

import 'package:any_chat/enum/view_state.dart';
import 'package:any_chat/locator.dart';
import 'package:any_chat/models/message.dart';
import 'package:any_chat/viewmodels/chat_page_model.dart';
import 'package:any_chat/viewmodels/home_page_model.dart';
import 'package:web_socket_channel/io.dart';

class DjangoService {
  IOWebSocketChannel _channel;

  void connect() {
    _channel =
        IOWebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8000/ws/chat/'));
    final model = locator<ChatPageModel>();
    _channel.stream.listen((event) {
      final jsn = json.decode(event);
      print(event);
      switch (jsn["type"]) {
        case "user.typing":
          model.switchTyping();
          break;
        case "user.searching":
          model.setState(ViewState.Waiting);
          break;
        case "user.found":
          model.setState(ViewState.Idle);
          break;
        case "user.disconnected":
          locator<HomePageModel>().justDisconnected = true;
          locator<ChatPageModel>().exitChat();
          break;
        case "message.recieve":
          addMessage(Message(isSender: false, text: jsn["message"]));
          break;
      }
    });
  }

  void disconnect() {
    _channel.sink.close();
  }

  void sendTyping() {
    _channel.sink.add(json.encode({"type": "typing"}));
  }

  void sendMessage(Message message) {
    _channel.sink
        .add(json.encode({"type": "message", "message": message.text}));
  }

  void addMessage(Message message) {
    locator<ChatPageModel>().addMessage(message);
  }
}
