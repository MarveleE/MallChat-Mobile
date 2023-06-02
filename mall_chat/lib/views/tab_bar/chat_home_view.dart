import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/color.dart';

import 'chat_home_friends_view.dart';
import 'chat_home_list_view.dart';

class ChatHomeView extends StatelessWidget {
  const ChatHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Image(
            image: AssetImage("assets/1.png"),
            fit: BoxFit.fitWidth,
          ),
          Column(
            children: [
              userHeaderWidget(),
              const SizedBox(height: 20),
              userFriendsScrollView(),
              const SizedBox(height: 34),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: ChatHomeListContainerView(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox userFriendsScrollView() {
    return SizedBox(
      height: 101,
      // padding: const EdgeInsets.only(left: 20),
      child: ChatHomeFriendsView(),
    );
  }

  Container userHeaderWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 74),
      child: Row(
        children: [
          const Image(
              image: AssetImage("assets/avatars/01.png"),
              width: 40,
              height: 40),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning",
                style: TextStyle(
                    color: ThemeProvider.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Alex bender",
                style: TextStyle(
                    color: ThemeProvider.textActivate,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
          const Spacer(),
          const Image(
            image: AssetImage("assets/icons/Search.png"),
            width: 35,
            height: 35,
          ),
          const SizedBox(
            width: 10,
          ),
          const Image(
            image: AssetImage("assets/icons/Plus.png"),
            width: 35,
            height: 35,
          ),
        ],
      ),
    );
  }
}
