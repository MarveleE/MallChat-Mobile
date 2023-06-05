import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import '../Model/chat_model.dart';
import '../Model/chat_socket.dart';

class ChatDetailViewModel extends ChangeNotifier {
  List<ListElement> chatMessages = [];
  late StreamSubscription<dynamic> subscription;
  ScrollController scrollController = ScrollController();
  String? cursor;
  late Timer timer;
  bool isLoading = false;

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://api.mallchat.cn/websocket'),
  );

  ChatDetailViewModel() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        sendSocketMessage("{type: 2}");
      },
    );
  }

  void sendPostRequest(String message) async {
    print("message: $message");

    const url = "https://api.mallchat.cn/capi/chat/msg";

    Map<String, String> headers = {
      "Accept": "*/*",
      "Accept-Language": "en-US,en;q=0.9,zh;q=0.8,zh-CN;q=0.7",
      "Authorization":
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOjExODk5LCJjcmVhdGVUaW1lIjoxNjg1OTU2NTcyfQ.Df9mT0y2RECxJNRyV5mAX9iaOqKFPKQJi1GVxGwIwjw",
      "Connection": "keep-alive",
      "Content-Type": "application/json; charset=utf-8",
      "DNT": "1",
      "Origin": "https://mallchat.cn",
      "Referer": "https://mallchat.cn/",
      "Sec-Fetch-Dest": "empty",
      "Sec-Fetch-Mode": "cors",
    };

    Map<String, dynamic> data = {"content": message, "roomId": 1};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // 请求成功
        final responseData = json.decode(response.body);
        print(responseData);
      } else {
        // 请求失败
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // 异常处理
      print('Error: $e');
    }
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

        if (scrollController.position.pixels == 0) {
          scrollToBottom();
        } else {
          //MARK: - new message indicator
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

    isLoading = false;
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
