import 'package:flutter/material.dart';
import 'Model/home_chat_history_data.dart';
import 'home_chat_history_list_row_view.dart';

// ignore: must_be_immutable
class HomeChatHistoryListView extends StatelessWidget {
  HomeChatHistoryListView({super.key});

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
        return HomeChatHistoryRowView(
          chatRowData: chatListData[index],
        );
      },
    );
  }
}
