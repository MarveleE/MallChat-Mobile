class APIURL {
  static final historyLatest20 = Uri.parse(
      "https://api.mallchat.cn/capi/chat/public/msg/page?pageSize=20&roomId=1");

  static final historyByCursor = Uri.parse(
      "https://api.mallchat.cn/capi/chat/public/msg/page?pageSize=20&cursor=20&roomId=1");

  static final websocket = Uri.parse("wss://api.mallchat.cn/websocket");

  static final sendingMessage =
      Uri.parse("https://api.mallchat.cn/capi/chat/msg");
}
