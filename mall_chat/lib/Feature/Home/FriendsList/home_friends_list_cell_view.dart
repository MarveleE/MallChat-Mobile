import 'package:flutter/material.dart';

import '../../../Constants/color.dart';

// ignore: must_be_immutable
class ChatHomeFriendsCardView extends StatelessWidget {
  ChatHomeFriendsCardView(
      {super.key,
      required this.imageName,
      required this.friendName,
      required this.showPlusButton});
  String imageName;
  String friendName;
  bool showPlusButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93,
      height: 101.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image(
                image: AssetImage("assets/avatars/$imageName"),
                width: 50,
                height: 50),
            showPlusButton
                ? const Image(
                    image: AssetImage("assets/icons/Plus_blue.png"),
                    width: 20,
                    height: 20,
                  )
                : Container(
                    width: 0,
                  ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          friendName,
          style: TextStyle(
              color: ThemeProvider.textActivate,
              fontSize: 12,
              fontWeight: FontWeight.w700),
        )
      ]),
    );
  }
}
