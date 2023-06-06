import 'dart:math';

import '../Feature/ChatDetail/Model/chat_model.dart';

List<ListElement> generateMockData() {
  final List<ListElement> mockData = [];

  for (int i = 0; i < 10; i++) {
    final fromUser = FromUser(
      username: "User $i",
      uid: i,
      avatar: "avatar$i.png",
      locPlace: "Location $i",
      badge: Badge(
        img: "badge$i.png",
        describe: "Badge $i",
      ),
    );

    final message = Message(
      id: i,
      sendTime: DateTime.now().millisecondsSinceEpoch,
      content: "Message $i",
      urlTitleMap: UrlTitleMap(),
      type: 0,
      messageMark: MessageMark(
        likeCount: Random().nextInt(100),
        userLike: Random().nextInt(2),
        dislikeCount: Random().nextInt(100),
        userDislike: Random().nextInt(2),
      ),
    );

    final listElement = ListElement(
      fromUser: fromUser,
      message: message,
      isMe: i % 2 == 0,
    );

    mockData.add(listElement);
  }

  return mockData;
}
