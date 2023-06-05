import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/color.dart';
import 'package:mall_chat/Constants/extension.dart';
import 'package:mall_chat/model/chat_model.dart';
import 'package:mall_chat/views/chat_detail/chat_detail_main_viewModel.dart';
import 'package:provider/provider.dart';

class ChatDetailMainView extends StatefulWidget {
  const ChatDetailMainView({super.key});

  @override
  State<ChatDetailMainView> createState() => _ChatDetailMainViewState();
}

class _ChatDetailMainViewState extends State<ChatDetailMainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatDetailViewModel>(
      create: (_) => ChatDetailViewModel(),
      child: const Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            ChatDetailListView(),
            ChatDetailNavigationBarView(),
          ],
        ),
      ),
    );
  }
}

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
        viewModel.isLoading == false) {
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
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: model.chatMessages.length,
            itemBuilder: ((context, index) {
              //MARK - List Row
              return Padding(
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
              onTap: () {},
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
