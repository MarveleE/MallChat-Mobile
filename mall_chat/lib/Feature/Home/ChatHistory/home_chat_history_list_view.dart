import 'package:flutter/material.dart';
import 'package:mall_chat/Feature/ChatDetail/ViewModel/chat_detail_main_view_model.dart';
import 'package:provider/provider.dart';

import '../../../Constants/view_extention.dart';
import 'home_chat_history_list_row_view.dart';

// ignore: must_be_immutable
class HomeChatHistoryListView extends StatelessWidget {
  const HomeChatHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    print("Home List View rebuid");
    return Consumer<ChatDetailViewModel>(builder: (context, viewModel, _) {
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
    });
  }
}
