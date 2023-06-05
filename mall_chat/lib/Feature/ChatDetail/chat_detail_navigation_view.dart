import 'package:flutter/material.dart';

class ChatDetailNavigationBarView extends StatelessWidget {
  const ChatDetailNavigationBarView({super.key});

  double headerHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: headerHeight(context),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Image(
              image: AssetImage("assets/icons/Back.png"),
              width: 30,
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              const Image(
                image: AssetImage("assets/avatars/05.png"),
                width: 40,
                height: 40,
              ),
              Transform.translate(
                offset: const Offset(-28, -8),
                child: const Image(
                  image: AssetImage("assets/avatars/07.png"),
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
