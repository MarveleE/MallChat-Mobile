import 'package:flutter/material.dart';
import 'chat_detail_list_view.dart';
import 'chat_detail_navigation_view.dart';

class ChatDetailMainView extends StatefulWidget {
  const ChatDetailMainView({super.key});

  @override
  State<ChatDetailMainView> createState() => _ChatDetailMainViewState();
}

class _ChatDetailMainViewState extends State<ChatDetailMainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ChatDetailListView(),
          ChatDetailNavigationBarView(),
        ],
      ),
    );
  }
}
