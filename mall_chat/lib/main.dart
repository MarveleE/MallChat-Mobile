import 'package:flutter/material.dart';
import 'package:mall_chat/views/tab_bar/chat_home_view.dart';
import 'package:mall_chat/views/tab_bar/tab_bar_view.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ChatHomeView(),
              ChatTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}
