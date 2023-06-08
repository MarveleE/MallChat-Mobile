import 'dart:convert';

import 'package:mall_chat/Feature/APIServer/user_service.dart';

import '../../main.dart';
import 'Model/member_model.dart';

class APIURL {
  static final historyLatest20 = Uri.parse(
      "https://api.mallchat.cn/capi/chat/public/msg/page?pageSize=20&roomId=1");

  static final historyByCursor = Uri.parse(
      "https://api.mallchat.cn/capi/chat/public/msg/page?pageSize=20&cursor=20&roomId=1");

  static final websocket = Uri.parse("wss://api.mallchat.cn/websocket");

  static final sendingMessage =
      Uri.parse("https://api.mallchat.cn/capi/chat/msg");
}

class UserInfo {
  Map<String, String> get userHeader {
    return {
      "Accept": "*/*",
      "Accept-Language": "en-US,en;q=0.9,zh;q=0.8,zh-CN;q=0.7",
      "Authorization": "Bearer ${loadData()?.token}",
      "Connection": "keep-alive",
      "Content-Type": "application/json; charset=utf-8",
      "DNT": "1",
      "Origin": "https://mallchat.cn",
      "Referer": "https://mallchat.cn/",
      "Sec-Fetch-Dest": "empty",
      "Sec-Fetch-Mode": "cors",
    };
  }

  MemberData? loadData() {
    String? jsonString = prefs.getString(User.prefrencesKey);
    print("get $jsonString from local");
    if (jsonString != null) {
      return MemberData.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }
}
