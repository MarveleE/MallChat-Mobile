import 'package:flutter/material.dart';
import 'package:mall_chat/Constants/extension.dart';

import '../../Constants/color.dart';
import 'Model/chat_model.dart';

class ChatDetailListCellView extends StatelessWidget {
  const ChatDetailListCellView({
    super.key,
    required this.data,
  });

  final ListElement data;

  @override
  Widget build(BuildContext context) {
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
