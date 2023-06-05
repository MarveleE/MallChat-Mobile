class ChatHomeListData {
  String avatarName;
  String name;
  String message;
  String time;
  int? unreadMessage;

  ChatHomeListData(
      {required this.avatarName,
      required this.name,
      required this.message,
      required this.time,
      this.unreadMessage});
}
