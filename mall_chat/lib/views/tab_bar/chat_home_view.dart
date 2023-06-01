import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/color.dart';

class ChatHomeView extends StatelessWidget {
  const ChatHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Image(image: AssetImage("assets/1.png"), fit: BoxFit.fitWidth,),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 74),
                child: Row(
                  children: [
                    const Image(image: AssetImage("assets/avatars/01.png"), width: 40, height: 40,),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good morning", style: TextStyle(color: ThemeProvider.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),),
                        Text("Alex bender", style: TextStyle(color: ThemeProvider.textActivate, fontSize: 20, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    const Spacer(),
                    const Image(image: AssetImage("assets/icons/Search.png"), width: 40, height: 40,),
                    const SizedBox(width: 10,),
                    const Image(image: AssetImage("assets/icons/Plus.png"), width: 40, height: 40,),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}