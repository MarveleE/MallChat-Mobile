import 'package:intl/intl.dart';

extension DateTimeExtension on int {
  String formatTimestampToDateTime() {
    int timestamp = this; // 例如，假设时间戳为 1622770200

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp); // 将时间戳转换为 DateTime

    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime); // 格式化日期时间

    return formattedDateTime;
  }
}
