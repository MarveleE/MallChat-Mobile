import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mall_chat/views/home/chat_home_view.dart';
import 'package:mall_chat/views/tab_bar/tab_bar_view.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "SFProDisplay"),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
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
