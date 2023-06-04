import 'dart:convert';

SocketMessage socketMessageFromJson(String str) =>
    SocketMessage.fromJson(json.decode(str));

String socketMessageToJson(SocketMessage data) => json.encode(data.toJson());

class SocketMessage {
  int type;
  Data data;

  SocketMessage({
    required this.type,
    required this.data,
  });

  factory SocketMessage.fromJson(Map<String, dynamic> json) => SocketMessage(
        type: json["type"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
      };
}

class Data {
  List<ChangeList> changeList;
  int onlineNum;

  Data({
    required this.changeList,
    required this.onlineNum,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        changeList: List<ChangeList>.from(
            json["changeList"].map((x) => ChangeList.fromJson(x))),
        onlineNum: json["onlineNum"],
      );

  Map<String, dynamic> toJson() => {
        "changeList": List<dynamic>.from(changeList.map((x) => x.toJson())),
        "onlineNum": onlineNum,
      };
}

class ChangeList {
  int uid;
  String name;
  String avatar;
  int activeStatus;
  int lastOptTime;

  ChangeList({
    required this.uid,
    required this.name,
    required this.avatar,
    required this.activeStatus,
    required this.lastOptTime,
  });

  factory ChangeList.fromJson(Map<String, dynamic> json) => ChangeList(
        uid: json["uid"],
        name: json["name"],
        avatar: json["avatar"],
        activeStatus: json["activeStatus"],
        lastOptTime: json["lastOptTime"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "avatar": avatar,
        "activeStatus": activeStatus,
        "lastOptTime": lastOptTime,
      };
}
