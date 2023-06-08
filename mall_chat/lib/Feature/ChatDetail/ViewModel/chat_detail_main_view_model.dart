import 'package:flutter/material.dart';
import 'package:mall_chat/Feature/APIServer/Model/member_model.dart';
import 'package:mall_chat/Feature/APIServer/chat_message_service.dart';
import 'package:mall_chat/Feature/APIServer/chat_socket_service.dart';
import '../Model/chat_model.dart';

// https://api.mallchat.cn/capi/chat/public/member/page?pageSize=20
class ChatDetailViewModel extends ChangeNotifier {
  List<ListElement> chatMessages = [];
  String? loginUrl;
  ChatMessageService messageService = ChatMessageService();
  ChatSocketService socketService = ChatSocketService();
  Function(MemberData)? onUserDataReceived;

  ChatDetailViewModel() {
    print("init ViewModel");
    messageService.getHistory().then((value) {
      addMessageData(value);
    });
    setUpSocket();
  }
  void setUpSocket() {
    socketService.onMessageReceived = (message) {
      chatMessages.insert(0, message);
      notifyListeners();
    };

    socketService.onLoginUrlReceived = (url) {
      loginUrl = url;
      notifyListeners();
    };

    socketService.onUserDataReceived = (user) {
      onUserDataReceived?.call(user);
    };

    messageService.onSendMsgResponse = (response) {
      chatMessages.insert(0, response.data);
      notifyListeners();
    };
  }

  void sendMessage(String message) {
    messageService.sendPostRequest(message);
  }

  void toggleShowLogin() {
    loginUrl = null;
    notifyListeners();
  }

  void addMessageData(List<ListElement> messages) {
    chatMessages.addAll(messages.reversed);
    notifyListeners();
  }
}
