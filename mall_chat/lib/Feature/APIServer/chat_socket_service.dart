import 'dart:async';
import 'dart:convert';

import '../ChatDetail/Model/chat_model.dart';
import '../ChatDetail/Model/chat_socket.dart';
import 'package:mall_chat/Feature/APIServer/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatSocketService {
  late StreamSubscription<dynamic> subscription;

  late Timer heartBeatTimer;

  Function(ListElement)? onMessageReceived;

  final channel = WebSocketChannel.connect(
    APIURL.websocket,
  );

  ChatSocketService() {
    heartBeatTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        sendSocketMessage("{type: 2}");
      },
    );
    startChat();
  }

  void startChat() {
    print("Start Socket connet");
    subscription = channel.stream.listen((event) {
      print(event);
      final responseData = json.decode(event);
      if (responseData["type"] == 4) {
        final socketMessage = SocketMessage.fromJson(responseData);
        print("socket recive message: ${socketMessage.data.message.content}");
        if (onMessageReceived != null) {
          onMessageReceived!(socketMessage.data);
        }
      }
    }, onError: (error) {
      print(error);
    }, onDone: () {
      print("done");
    });
  }

  void sendSocketMessage(String message) {
    channel.sink.add(message);
  }

  void closeSocket() {
    heartBeatTimer.cancel();
    channel.sink.close();
    subscription.cancel();
  }

  void dispose() {
    closeSocket();
  }
}
