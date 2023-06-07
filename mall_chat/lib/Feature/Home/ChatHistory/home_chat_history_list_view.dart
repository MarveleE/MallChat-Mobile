import 'package:flutter/material.dart';
import 'package:mall_chat/Feature/ChatDetail/ViewModel/chat_detail_main_view_model.dart';
import 'package:provider/provider.dart';
import '../../../Constants/view_extention.dart';
import 'home_chat_history_list_row_view.dart';

// ignore: must_be_immutable
class HomeChatHistoryListView extends StatefulWidget {
  const HomeChatHistoryListView({super.key});

  @override
  State<HomeChatHistoryListView> createState() =>
      _HomeChatHistoryListViewState();
}

class _HomeChatHistoryListViewState extends State<HomeChatHistoryListView> {
  late ChatDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<ChatDetailViewModel>(context, listen: true);
    print("Home List View rebuid");
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: viewModel.chatMessages.isEmpty ? 0 : 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return HomeChatHistoryRowView(
            key: UniqueKey(),
            chatRowData: viewModel.chatMessages.isEmpty
                ? generateMockData()[0]
                : viewModel.chatMessages.first);
      },
    );
  }
}
