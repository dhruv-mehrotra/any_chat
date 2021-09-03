import 'package:any_chat/models/message.dart';
import 'package:web_socket_channel/io.dart';

class DjangoService {
  IOWebSocketChannel _channel;

  void connect() {
    _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://116.73.195.34:8000/ws/chat/'));
    _channel.stream.listen((event) {
      //handle stuff
    });
  }

  void disconnect() {
    _channel.sink.close();
  }

  void sendMessage(Message message) {
    // send message to server
  }

  void addMessage(Message message) {
    //add message to list and notify listeners
  }
}
