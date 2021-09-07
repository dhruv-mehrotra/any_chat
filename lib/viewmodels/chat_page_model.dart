import 'package:any_chat/enum/view_state.dart';
import 'package:any_chat/locator.dart';
import 'package:any_chat/models/message.dart';
import 'package:any_chat/services/django_service.dart';
import 'package:any_chat/viewmodels/base_model.dart';
import 'package:any_chat/viewmodels/home_page_model.dart';
import 'package:flutter/cupertino.dart';

class ChatPageModel extends BaseModel {
  DjangoService djangoService;
  BuildContext context;
  TextEditingController controller;
  FocusNode focusNode;
  bool strangerTyping = false;
  List<Message> _messages = [];

  void onModelReady() {
    focusNode = new FocusNode();
    controller = new TextEditingController();
    focusNode.addListener(() {
      djangoService.sendTyping();
    });
    locator<HomePageModel>().justDisconnected = false;
    strangerTyping = false;
    djangoService = locator<DjangoService>();
    setState(ViewState.Busy);
    djangoService.connect();
    setState(ViewState.Idle);
  }

  void onModelDestroyed() {
    _messages = [];
    djangoService.disconnect();
  }

  void exitChat() {
    Navigator.of(context).pop();
  }

  void switchTyping() {
    strangerTyping = !strangerTyping;
    notifyListeners();
  }

  List<Message> get messages => _messages;

  void sendMessage(Message message) {
    djangoService.sendMessage(message);
    addMessage(message);
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
