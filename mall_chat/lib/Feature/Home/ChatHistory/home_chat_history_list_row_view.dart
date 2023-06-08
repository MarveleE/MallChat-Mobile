import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/extension.dart';
import 'package:mall_chat/Feature/ChatDetail/Model/chat_model.dart';
import '../../../Constants/color.dart';
import '../../ChatDetail/chat_detail_main_view.dart';

// ignore: must_be_immutable
class HomeChatHistoryRowView extends StatelessWidget {
  HomeChatHistoryRowView({super.key, required this.chatRowData});
  ListElement chatRowData;

  @override
  Widget build(BuildContext context) {
    print("${chatRowData.message.content} was refreshed");
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const ChatDetailMainView()),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 30),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            avatar(),
            const SizedBox(width: 10),
            nameAndMessage(),
            const Spacer(),
            unreadAndTime()
          ],
        ),
      ),
    );
  }

  Container avatar() {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      child: const Image(
          image: AssetImage("assets/avatars/MallChat.png"),
          fit: BoxFit.cover,
          width: 50,
          height: 50),
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
          child: const Text(
            "2",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          chatRowData.message.sendTime.formatTimestampToDateTime(),
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
          "MallChat用户群",
          style: TextStyle(
              color: ThemeProvider.textActivate,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Text(
            "${chatRowData.fromUser.username}: ${chatRowData.message.content}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
                color: ThemeProvider.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}
