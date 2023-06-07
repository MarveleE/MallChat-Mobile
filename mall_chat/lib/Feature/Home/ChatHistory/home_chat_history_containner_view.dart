import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Constants/color.dart';
import 'home_chat_history_list_view.dart';

// ignore: must_be_immutable
class HomeChatHistoryContainnerView extends StatelessWidget {
  const HomeChatHistoryContainnerView({super.key});

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
        const Expanded(child: HomeChatHistoryListView()),
      ],
    );
  }
}
