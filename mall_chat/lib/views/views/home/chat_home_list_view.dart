import 'package:flutter/material.dart';
import '../../../Constants/color.dart';

// ignore: must_be_immutable
class ChatHomeListContainerView extends StatelessWidget {
  const ChatHomeListContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chats",
          style: TextStyle(
              color: ThemeProvider.textActivate,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
        ChatHomeListView(),
      ],
    );
  }
}

class ChatHomeListData {
  String avatarName;
  String name;
  String message;
  String time;
  int? unreadMessage;

  ChatHomeListData(
      {required this.avatarName,
      required this.name,
      required this.message,
      required this.time,
      this.unreadMessage});
}

// ignore: must_be_immutable
class ChatHomeListView extends StatelessWidget {
  ChatHomeListView({super.key});

  List<ChatHomeListData> chatListData = [
    ChatHomeListData(
        avatarName: "assets/avatars/03.png",
        name: "John Doe",
        message: "Awesome",
        time: "Today, 12:25",
        unreadMessage: 2),
    ChatHomeListData(
        avatarName: "assets/avatars/04.png",
        name: "Groot Chen",
        message: "OK~!",
        time: "10:00",
        unreadMessage: 2),
    ChatHomeListData(
        avatarName: "assets/avatars/05.png",
        name: "Sherman Chen",
        message: "Sounds Good!",
        time: "10:00",
        unreadMessage: 2),
    ChatHomeListData(
        avatarName: "assets/avatars/06.png",
        name: "Kenny Yu",
        message: "Got it!",
        time: "10:00",
        unreadMessage: 2),
    ChatHomeListData(
        avatarName: "assets/avatars/07.png",
        name: "Darrell Steward",
        message: "See you soon bro!",
        time: "10:00",
        unreadMessage: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: chatListData.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ChatHomeListRowView(
          chatRowData: chatListData[index],
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ChatHomeListRowView extends StatelessWidget {
  ChatHomeListRowView({super.key, required this.chatRowData});
  ChatHomeListData chatRowData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          avatar(),
          const SizedBox(width: 10),
          nameAndMessage(),
          const Spacer(),
          unreadAndTime()
        ],
      ),
    );
  }

  Stack avatar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(image: AssetImage(chatRowData.avatarName), width: 50, height: 50),
        Transform.translate(
          offset: const Offset(0, 9),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 60),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 7, right: 7),
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(130),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 8,
                    spreadRadius: -4,
                    color: Color(0xFF6F6F87),
                  ),
                ]),
            child: Text("Awesomesss",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 10,
                    color: ThemeProvider.textActivate,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Column unreadAndTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            color: "#7ED3B2".toColor(),
            borderRadius: BorderRadius.circular(8.5),
          ),
          child: Text(
            chatRowData.unreadMessage.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          chatRowData.time,
          style: TextStyle(
              color: ThemeProvider.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 12),
        ),
      ],
    );
  }

  Column nameAndMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chatRowData.name,
          style: TextStyle(
              color: ThemeProvider.textActivate,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        const SizedBox(height: 5),
        Text(
          chatRowData.message,
          style: TextStyle(
              color: ThemeProvider.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 12),
        ),
      ],
    );
  }
}
