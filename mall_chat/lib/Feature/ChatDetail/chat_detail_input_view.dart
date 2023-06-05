import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mall_chat/Constants/color.dart';
import 'package:mall_chat/Feature/ChatDetail/ViewModel/chat_detail_main_view_model.dart';
import 'package:provider/provider.dart';

class ChatDetailInputView extends StatefulWidget {
  ChatDetailInputView({super.key, required this.keyboardHeight});
  double keyboardHeight;

  @override
  State<ChatDetailInputView> createState() => _ChatDetailInputViewState();
}

class _ChatDetailInputViewState extends State<ChatDetailInputView> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ChatDetailViewModel model = Provider.of<ChatDetailViewModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.keyboardHeight,
      color: Colors.white,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: "#F5F5F5".toColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              padding: const EdgeInsets.only(left: 8, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Plus.svg",
                    width: 25,
                    colorFilter:
                        ColorFilter.mode("#FFB0FE".toColor(), BlendMode.color),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      // maxLength: 1,
                      controller: _textEditingController,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // disable the oytline border will make text on center in textfield
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          color: "#BDBDBD".toColor(),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/icons/Emoji.svg", width: 25),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              //TODO: When send meesage, be sure the list has the message then reset the textfield
              model.sendPostRequest(_textEditingController.text);
              _textEditingController.text = "";
            },
            child: const Image(
              image: AssetImage("assets/icons/Send.png"),
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
