import 'package:flutter/material.dart';
import 'chat_detail_list_view.dart';
import 'chat_detail_navigation_view.dart';

class ChatDetailMainView extends StatelessWidget {
  const ChatDetailMainView({super.key});

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
