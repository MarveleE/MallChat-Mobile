import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'ViewModel/chat_detail_main_view_model.dart';
import 'chat_detail_list_view.dart';
import 'chat_detail_navigation_view.dart';

class ChatDetailMainView extends StatelessWidget {
  const ChatDetailMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const ChatDetailListView(),
          const ChatDetailNavigationBarView(),
          Consumer<ChatDetailViewModel>(
            builder: (context, viewModel, _) {
              return viewModel.loginUrl == null
                  ? Container()
                  : GestureDetector(
                      onTap: () => viewModel.toggleShowLogin(),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: QrImageView(
                            data: viewModel.loginUrl ?? "",
                            version: QrVersions.auto,
                          ),
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
