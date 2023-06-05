import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/extension.dart';
import 'package:provider/provider.dart';
import '../../Constants/color.dart';
import 'Model/chat_model.dart';
import 'ViewModel/chat_detail_main_view_model.dart';

class ChatDetailListView extends StatefulWidget {
  const ChatDetailListView({super.key});

  @override
  State<ChatDetailListView> createState() => _ChatDetailListViewState();
}

class _ChatDetailListViewState extends State<ChatDetailListView> {
  double headerHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 60;
  }

  double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom + 60;
  }

  late TextEditingController _textEditingController;

  late ScrollController _scrollController;

  late ChatDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 800), () {
        viewModel = Provider.of<ChatDetailViewModel>(context, listen: false);
        _scrollController = viewModel.scrollController;
        _scrollController.addListener(pullToRefreash);
        viewModel.getChatHistory();
        viewModel.startChat();
      });
    });
  }

  void pullToRefreash() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        viewModel.isLoading == false &&
        _scrollController.position.isScrollingNotifier.value == false) {
      viewModel.getChatHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    ChatDetailViewModel model = Provider.of<ChatDetailViewModel>(context);
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        color: ThemeProvider.backgroundWhite,
        alignment: Alignment.topCenter,
        child: RotatedBox(
          quarterTurns: 2,
          child: ListView.builder(
            controller: model.scrollController,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(
              top: keyboardHeight(context),
              bottom: headerHeight(context) + 10,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: model.chatMessages.length + 1,
            itemBuilder: ((context, index) {
              //MARK - List Row
              return index == model.chatMessages.length
                  ? Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const CupertinoActivityIndicator(animating: true),
                    )
                  : Padding(
                      // while the RotatedBox Apply in The ListView,
                      // make the top as the bottom, the bottom as the top,
                      //MARK - Padding for the each item's horizontal and item spacing
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                      ),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: chatRowView(
                          context,
                          model.chatMessages[index],
                        ),
                      ),
                    );
            }),
          ),
        ),
      ),

      //MARK - Chat Input View
      Container(
        width: MediaQuery.of(context).size.width,
        height: keyboardHeight(context),
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
                    const Image(
                        image: AssetImage("assets/avatars/01.png"), width: 25),
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
                image: AssetImage("assets/icons/Plus.png"),
                width: 30,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Row chatRowView(BuildContext context, ListElement data) {
    return Row(
      children: [
        data.isMe ? const Spacer() : Container(),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
            minWidth: MediaQuery.of(context).size.width * 0.2,
          ),
          decoration: BoxDecoration(
            color: data.isMe ? "#FFB0FE".toColor() : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MARK - Chat User info
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image(
                      image: NetworkImage(data.fromUser.avatar),
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 5),

                  // Name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.fromUser.username,
                        style: TextStyle(
                          color: data.isMe
                              ? "#FFFFFF".toColor()
                              : ThemeProvider.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${data.fromUser.locPlace}",
                        style: TextStyle(
                          color: data.isMe
                              ? "#FFFFFF".toColor()
                              : ThemeProvider.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Time
                  Text(
                    data.message.sendTime.formatTimestampToDateTime(),
                    style: TextStyle(
                      color: data.isMe
                          ? "#FFFFFF".toColor()
                          : ThemeProvider.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // MARK - Chat Message
              Text(
                data.message.content,
                style: TextStyle(
                  height: 1.5,
                  color: data.isMe
                      ? "#FFFFFF".toColor()
                      : ThemeProvider.textActivate,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}