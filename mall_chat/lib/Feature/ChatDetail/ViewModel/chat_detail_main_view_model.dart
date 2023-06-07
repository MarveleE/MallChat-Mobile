import 'package:flutter/material.dart';
import 'package:mall_chat/Feature/APIServer/chat_message_service.dart';
import 'package:mall_chat/Feature/APIServer/chat_socket_service.dart';
import '../Model/chat_model.dart';

// https://api.mallchat.cn/capi/chat/public/member/page?pageSize=20
class ChatDetailViewModel extends ChangeNotifier {
  List<ListElement> chatMessages = [];
  ChatMessageService messageService = ChatMessageService();
  ChatSocketService socketService = ChatSocketService();

  ScrollController scrollController = ScrollController();

  ChatDetailViewModel() {
    print("init ViewModel");
    messageService.getHistory().then((value) {
      chatMessages = value;
      notifyListeners();
      // scrollToBottom();
    });
    socketService.onMessageReceived = (message) {
      chatMessages.insert(0, message);
      notifyListeners();
      // scrollToBottom();
    };
  }

  void scrollOffset(double value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(
        value + 100,
      );
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}
