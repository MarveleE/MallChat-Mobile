import 'package:flutter/material.dart';
import 'FriendsList/Model/home_friends_data.dart';
import 'FriendsList/home_friends_list_cell_view.dart';

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
    return SizedBox(
      height: 101,
      child: ListView(
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
      ),
    );
  }
}

// ignore: must_be_immutable
