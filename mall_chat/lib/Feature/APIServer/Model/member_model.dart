import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  int type;
  MemberData data;

  Member({
    required this.type,
    required this.data,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        type: json["type"],
        data: MemberData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
      };
}

class MemberData {
  int uid;
  String avatar;
  String token;
  String name;
  int power;

  MemberData({
    required this.uid,
    required this.avatar,
    required this.token,
    required this.name,
    required this.power,
  });

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
        uid: json["uid"],
        avatar: json["avatar"],
        token: json["token"],
        name: json["name"],
        power: json["power"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "avatar": avatar,
        "token": token,
        "name": name,
        "power": power,
      };
}
