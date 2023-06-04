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
      final responseData = json.decode(utf8.decode(event));
      if (responseData["type"] == 5) {
        final socketMessage = SocketMessage.fromJson(responseData);
        // final socketMessageChangeList = socketMessageData["changeList"];
        for (var item in socketMessage.data.changeList) {
          if (item["activeStatus"] == 1) {
            print("online");
          } else {
            print("offline");
          }
          Chat chat = Chat(
            success: true,
            data: ChatData(
              cursor: "",
              isLast: false,
              list: [
                ListElement(
                  isMe: false,
                  fromUser: FromUser(avatar: item.avatar, name: item.name),
                )
              ],
            ),
          );
        }
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
      cursor = chat.data.cursor;
      chatMessages.addAll(chat.data.list);
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }

    notifyListeners();

    scrollToBottom();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
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
