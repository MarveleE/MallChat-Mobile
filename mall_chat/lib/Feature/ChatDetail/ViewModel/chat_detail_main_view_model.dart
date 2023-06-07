import 'package:flutter/material.dart';
import 'package:mall_chat/Feature/APIServer/chat_message_service.dart';
import 'package:mall_chat/Feature/APIServer/chat_socket_service.dart';
import '../Model/chat_model.dart';

// https://api.mallchat.cn/capi/chat/public/member/page?pageSize=20
class ChatDetailViewModel extends ChangeNotifier {
  List<ListElement> chatMessages = [];
  ChatMessageService messageService = ChatMessageService();
  ChatSocketService socketService = ChatSocketService();

  ChatDetailViewModel() {
    print("init ViewModel");
    messageService.getHistory().then((value) {
      addMessageData(value);
    });
    socketService.onMessageReceived = (message) {
      chatMessages.insert(0, message);
      notifyListeners();
    };
  }

  void addMessageData(List<ListElement> messages) {
    chatMessages.addAll(messages.reversed);
    notifyListeners();
  }
}
