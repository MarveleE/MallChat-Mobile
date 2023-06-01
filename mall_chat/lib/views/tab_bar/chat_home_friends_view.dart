import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/color.dart';

// ignore: must_be_immutable
class ChatHomeFriendsView extends StatelessWidget {
  ChatHomeFriendsView({Key? key}) : super(key: key);

  List<ChatHomeFriendsData> friendData = [
    ChatHomeFriendsData(name: "Ass Story", imageName: "01.png"),
    ChatHomeFriendsData(name: "Colleen", imageName: "02.png"),
    ChatHomeFriendsData(name: "Soham", imageName: "03.png"),
    ChatHomeFriendsData(name: "Darrow", imageName: "04.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: friendData
          .asMap()
          .map((index, e) {
            return MapEntry(
              index,
              Padding(
                padding:
                    EdgeInsets.only(left: index == 0 ? 20.0 : 0.0, right: 10),
                child: ChatHomeFriendsCardView(
                  imageName: e.imageName,
                  friendName: e.name,
                  showPlusButton: e.name.startsWith("Ass") ? true : false,
                ),
              ),
            );
          })
          .values
          .toList(),
    );
  }
}

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

class ChatHomeFriendsData {
  String name;
  String imageName;

  ChatHomeFriendsData({required this.name, required this.imageName});
}
