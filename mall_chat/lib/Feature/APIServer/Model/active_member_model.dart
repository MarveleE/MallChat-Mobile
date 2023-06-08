// To parse this JSON data, do
//
//     final activeMember = activeMemberFromJson(jsonString);

import 'dart:convert';

ActiveMember activeMemberFromJson(String str) =>
    ActiveMember.fromJson(json.decode(str));

String activeMemberToJson(ActiveMember data) => json.encode(data.toJson());

class ActiveMember {
  int type;
  ActiveMemberData data;

  ActiveMember({
    required this.type,
    required this.data,
  });

  factory ActiveMember.fromJson(Map<String, dynamic> json) => ActiveMember(
        type: json["type"],
        data: ActiveMemberData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
      };
}

class ActiveMemberData {
  List<ChangeList> changeList;
  int onlineNum;

  ActiveMemberData({
    required this.changeList,
    required this.onlineNum,
  });

  factory ActiveMemberData.fromJson(Map<String, dynamic> json) =>
      ActiveMemberData(
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
  int activeStatus;
  int lastOptTime;

  ChangeList({
    required this.uid,
    required this.activeStatus,
    required this.lastOptTime,
  });

  factory ChangeList.fromJson(Map<String, dynamic> json) => ChangeList(
        uid: json["uid"],
        activeStatus: json["activeStatus"],
        lastOptTime: json["lastOptTime"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "activeStatus": activeStatus,
        "lastOptTime": lastOptTime,
      };
}
