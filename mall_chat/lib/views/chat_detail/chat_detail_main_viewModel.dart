import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import '../../model/chat_model.dart';
import '../../model/chat_socket.dart';

class ChatDetailViewModel extends ChangeNotifier {
  List<ListElement> chatMessages = [];
  late StreamSubscription<dynamic> subscription;
  ScrollController scrollController = ScrollController();
  String? cursor;
  late Timer timer;
  bool isLoading = false;

  ChatDetailViewModel() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        sendMessage("{type: 2}");
      },
    );
  }

  void startChat() {
    subscription = channel.stream.listen((event) {
      print(event);
      final responseData = json.decode(event);
      if (responseData["type"] == 4) {
        final socketMessage = SocketMessage.fromJson(responseData);
        print(socketMessage.data.message.content);
        chatMessages.insert(0, socketMessage.data);
        notifyListeners();
        scrollToBottom();
      }
    }, onError: (error) {
      print(error);
    }, onDone: () {
      print("done");
    });
  }

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://api.mallchat.cn/websocket'),
  );

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void getChatHistory() async {
    isLoading = true;
    var url = cursor == null
        ? Uri.parse(
            'https://api.mallchat.cn/capi/chat/public/msg/page?pageSize=20&roomId=1')
        : Uri.parse(
            'https://api.mallchat.cn/capi/chat/public/msg/page?pageSize=20&cursor=$cursor&roomId=1');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print(responseData);
      Chat chat = Chat.fromJson(responseData);

      if (cursor == null) {
        chatMessages.addAll(chat.data.list.reversed.toList());
        notifyListeners();
        scrollToBottom();
      } else {
        chatMessages.addAll(chat.data.list.reversed.toList());
        notifyListeners();
      }
      cursor = chat.data.cursor;
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      isLoading = false;
      notifyListeners();
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

  @override
  void dispose() {
    super.dispose();
    print("model dispose");
    channel.sink.close();
    subscription.cancel();
    timer.cancel();
  }
}

class ChatDetailData {
  String name;
  String imageName;
  String message;
  String time;
  bool isMe;

  ChatDetailData(
      {required this.name,
      required this.imageName,
      required this.message,
      required this.time,
      required this.isMe});
}
