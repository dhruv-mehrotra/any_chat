import 'package:any_chat/enum/view_state.dart';
import 'package:any_chat/locator.dart';
import 'package:any_chat/models/message.dart';
import 'package:any_chat/services/django_service.dart';
import 'package:any_chat/viewmodels/base_model.dart';
import 'package:web_socket_channel/io.dart';

class ChatPageModel extends BaseModel {
  DjangoService djangoService;

  List<Message> _messages = [
    Message(
        isSender: false,
        text:
            'hello1sdfsdfsdfsdfsdf ewer sdfjwesdo wwf sdfvjef sdkwe sdwej sdf'),
    Message(
        isSender: true,
        text: 'helasdasdfasdflo2 asdfklkjsd sdfiufpwie df sdnf wesdfjwej')
  ];

  void onModelReady() {
    djangoService = locator<DjangoService>();
    djangoService.connect();
  }

  void onModelDestroyed() {
    djangoService.disconnect();
  }

  List<Message> get messages => _messages;
  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
