import 'dart:async';
import 'dart:convert';
import 'package:mall_chat/Feature/APIServer/Model/login_model.dart';

import '../ChatDetail/Model/chat_model.dart';
import '../ChatDetail/Model/chat_socket.dart';
import 'package:mall_chat/Feature/APIServer/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'Model/active_member_model.dart';
import 'Model/member_model.dart';

class ChatSocketService {
  late StreamSubscription<dynamic> subscription;

  late Timer heartBeatTimer;

  Function(ListElement)? onMessageReceived;
  Function(String)? onLoginUrlReceived;
  Function(ActiveMemberData)? onActivateMemberReceived;
  Function(MemberData)? onUserDataReceived;

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
    subscription = channel.stream.listen((event) {
      final responseData = json.decode(event);
      switch (responseData["type"]) {
        case 1:
          recivedLoginUrl(responseData);
          break;
        case 3:
          recivedUserData(responseData);
        case 4:
          print("message");
          recivedMessage(responseData);
        case 5:
        default:
          print(responseData);
      }
    }, onError: (error) {
      print(error);
    }, onDone: () {
      print("done");
    });
  }

  void recivedUserData(dynamic responseData) {
    final socketMessage = Member.fromJson(responseData);
    final memberData = socketMessage.data;
    print("socket recive message: $memberData");
    if (onUserDataReceived != null) {
      onUserDataReceived!(memberData);
    }
  }

  void revicedActiveMember(dynamic responseData) {
    final socketMessage = ActiveMember.fromJson(responseData);
    final activeMember = socketMessage.data;
    print("socket recive message: ${activeMember.onlineNum}");
    if (onMessageReceived != null) {
      onActivateMemberReceived!(socketMessage.data);
    }
  }

  void recivedLoginUrl(dynamic responseData) {
    final socketMessage = LoginUrl.fromJson(responseData);
    final loginUrl = socketMessage.data.loginUrl;
    print("socket recive message: $loginUrl");
    if (onLoginUrlReceived != null) {
      onLoginUrlReceived!(loginUrl);
    }
  }

  void recivedMessage(dynamic responseData) {
    final socketMessage = SocketMessage.fromJson(responseData);
    print("socket recive message: ${socketMessage.data.message.content}");
    if (onMessageReceived != null) {
      onMessageReceived!(socketMessage.data);
    }
  }

  void requestLoginUrl() {
    sendSocketMessage("{type: 1}");
  }

  void sendSocketMessage(String message) {
    channel.sink.add(message);
  }

  void login() {
    sendSocketMessage("{type: 1");
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
