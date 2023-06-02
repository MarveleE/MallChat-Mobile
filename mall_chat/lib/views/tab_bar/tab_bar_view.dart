import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/color.dart';

class ChatTabBarView extends StatelessWidget {
  const ChatTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeProvider.backgroundWhite,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -30),
            blurRadius: 30,
            spreadRadius: -20,
            color: Color(0xFFF0F0F5),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 30, right: 30),
      width: MediaQuery.of(context).size.width,
      height: 90.0,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          ChatTabBarItem(
            iconName: "Discover_bar.png",
            tabName: "Discover",
            textColor: ThemeProvider.textSecondary,
          ),
          const Spacer(),
          ChatTabBarItem(
              iconName: "Chat_bar.png",
              tabName: "Chat",
              textColor: ThemeProvider.textActivate),
          const Spacer(),
          ChatTabBarItem(
            iconName: "Settings_bar.png",
            tabName: "Settings",
            textColor: ThemeProvider.textSecondary,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatTabBarItem extends StatelessWidget {
  ChatTabBarItem(
      {super.key,
      required this.iconName,
      required this.tabName,
      required this.textColor});
  String iconName;
  String tabName;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Image.asset(
            "assets/icons/$iconName",
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 2),
          Text(
            tabName,
            style: TextStyle(
                color: textColor, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
