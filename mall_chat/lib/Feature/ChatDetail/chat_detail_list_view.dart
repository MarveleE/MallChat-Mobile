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

  late ScrollController _scrollController;

  late ChatDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
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
                        child: ChatDetailListCellView(
                            context: context, data: model.chatMessages[index]),
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
