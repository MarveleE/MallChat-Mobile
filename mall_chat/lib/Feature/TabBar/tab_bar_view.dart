import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/color.dart';
import 'package:mall_chat/Feature/TabBar/tab_bar_item_view.dart';

class HomeTabBarView extends StatelessWidget {
  const HomeTabBarView({super.key});

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
          HomeTabBarItemView(
            iconName: "Discover_bar.png",
            tabName: "Discover",
            textColor: ThemeProvider.textSecondary,
          ),
          const Spacer(),
          HomeTabBarItemView(
              iconName: "Chat_bar.png",
              tabName: "Chat",
              textColor: ThemeProvider.textActivate),
          const Spacer(),
          HomeTabBarItemView(
            iconName: "Settings_bar.png",
            tabName: "Settings",
            textColor: ThemeProvider.textSecondary,
          ),
        ],
      ),
    );
  }
}
