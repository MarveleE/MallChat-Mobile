import 'package:flutter/material.dart';
import 'home_friends_list_view.dart';
import 'home_chat_history_containner_view.dart';
import 'home_user_header_view.dart';

class HomeChatView extends StatelessWidget {
  const HomeChatView({super.key});

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
              const HomeUserHeaderView(),
              const SizedBox(height: 20),
              ChatHomeFriendsView(),
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
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: HomeChatHistoryContainnerView(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
