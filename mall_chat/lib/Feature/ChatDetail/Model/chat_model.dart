import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  bool success;
  dynamic errCode;
  dynamic errMsg;
  ChatData data;

  Chat({
    required this.success,
    this.errCode,
    this.errMsg,
    required this.data,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        success: json["success"],
        errCode: json["errCode"],
        errMsg: json["errMsg"],
        data: ChatData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errCode": errCode,
        "errMsg": errMsg,
        "data": data.toJson(),
      };
}

class ChatData {
  String cursor;
  bool isLast;
  List<ListElement> list;

  ChatData({
    required this.cursor,
    required this.isLast,
    required this.list,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        cursor: json["cursor"],
        isLast: json["isLast"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "isLast": isLast,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  FromUser fromUser;
  Message message;
  bool isMe;

  ListElement({
    required this.fromUser,
    required this.message,
    this.isMe = false,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        fromUser: FromUser.fromJson(json["fromUser"]),
        message: Message.fromJson(json["message"]),
        isMe: FromUser.fromJson(json["fromUser"]).uid == 11899 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "fromUser": fromUser.toJson(),
        "message": message.toJson(),
        "isMe": isMe ? true : false,
      };
}

class FromUser {
  String username;
  int uid;
  String avatar;
  String? locPlace;
  Badge? badge;

  FromUser({
    required this.username,
    required this.uid,
    required this.avatar,
    required this.locPlace,
    this.badge,
  });

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
        username: json["username"],
        uid: json["uid"],
        avatar: json["avatar"],
        locPlace: json["locPlace"],
        badge: json["badge"] == null ? null : Badge.fromJson(json["badge"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "avatar": avatar,
        "locPlace": locPlace,
        "badge": badge?.toJson(),
      };
}

class Badge {
  String img;
  String describe;

  Badge({
    required this.img,
    required this.describe,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        img: json["img"],
        describe: json["describe"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "describe": describe,
      };
}

class Message {
  int id;
  int sendTime;
  String content;
  UrlTitleMap urlTitleMap;
  int type;
  MessageMark messageMark;
  Reply? reply;

  Message({
    required this.id,
    required this.sendTime,
    required this.content,
    required this.urlTitleMap,
    required this.type,
    required this.messageMark,
    this.reply,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        sendTime: json["sendTime"],
        content: json["content"],
        urlTitleMap: UrlTitleMap.fromJson(json["urlTitleMap"]),
        type: json["type"],
        messageMark: MessageMark.fromJson(json["messageMark"]),
        reply: json["reply"] == null ? null : Reply.fromJson(json["reply"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sendTime": sendTime,
        "content": content,
        "urlTitleMap": urlTitleMap.toJson(),
        "type": type,
        "messageMark": messageMark.toJson(),
        "reply": reply?.toJson(),
      };
}

class MessageMark {
  int likeCount;
  int userLike;
  int dislikeCount;
  int userDislike;

  MessageMark({
    required this.likeCount,
    required this.userLike,
    required this.dislikeCount,
    required this.userDislike,
  });

  factory MessageMark.fromJson(Map<String, dynamic> json) => MessageMark(
        likeCount: json["likeCount"],
        userLike: json["userLike"],
        dislikeCount: json["dislikeCount"],
        userDislike: json["userDislike"],
      );

  Map<String, dynamic> toJson() => {
        "likeCount": likeCount,
        "userLike": userLike,
        "dislikeCount": dislikeCount,
        "userDislike": userDislike,
      };
}

class Reply {
  int id;
  String username;
  String content;
  int canCallback;
  int gapCount;

  Reply({
    required this.id,
    required this.username,
    required this.content,
    required this.canCallback,
    required this.gapCount,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        username: json["username"],
        content: json["content"],
        canCallback: json["canCallback"],
        gapCount: json["gapCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "content": content,
        "canCallback": canCallback,
        "gapCount": gapCount,
      };
}

class UrlTitleMap {
  UrlTitleMap();

  factory UrlTitleMap.fromJson(Map<String, dynamic> json) => UrlTitleMap();

  Map<String, dynamic> toJson() => {};
}
