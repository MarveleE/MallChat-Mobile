import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../Constants/color.dart';
import 'ViewModel/chat_detail_main_view_model.dart';
import 'chat_detail_input_view.dart';
import 'chat_detail_list_cell_view.dart';

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

  final ScrollController _scrollController = ScrollController();

  Timer? reloadDataTimer;

  @override
  void initState() {
    super.initState();
    print("chat detail list init");
    _scrollController.addListener(pullToRefreash);
  }

  @override
  void dispose() {
    reloadDataTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void pullToRefreash() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      reloadDataTimer = Timer(const Duration(milliseconds: 500), () {
        reloadDataTimer?.cancel();
        print("pull to refreash");
        Provider.of<ChatDetailViewModel>(context, listen: false)
            .getChatHistory();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatDetailViewModel>(context, listen: true);
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        color: ThemeProvider.backgroundWhite,
        alignment: Alignment.topCenter,
        child: RotatedBox(
          quarterTurns: 2,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(
              top: keyboardHeight(context),
              bottom: headerHeight(context) + 10,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: viewModel.chatMessages.length + 1,
            itemBuilder: ((context, index) {
              //MARK - List Row
              return index == viewModel.chatMessages.length
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
                        child: ChatDetailListCellView(
                            context: context,
                            data: viewModel.chatMessages[index]),
                      ),
                    );
            }),
          ),
        ),
      ),

      //MARK - Chat Input View
      ChatDetailInputView(
        keyboardHeight: keyboardHeight(context),
      ),
    ]);
  }
}
