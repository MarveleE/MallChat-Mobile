import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class HomeTabBarItemView extends StatelessWidget {
  HomeTabBarItemView(
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
