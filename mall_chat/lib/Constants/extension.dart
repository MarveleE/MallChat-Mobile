import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on int {
  String formatTimestampToDateTime() {
    int timestamp = this; // 例如，假设时间戳为 1622770200

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp); // 将时间戳转换为 DateTime

    String formattedDateTime = DateFormat('HH:mm').format(dateTime); // 格式化日期时间

    return formattedDateTime;
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (offset < 0.0) {
      // 禁用顶部反弹效果
      return 0.0;
    } else {
      // 应用底部的默认反弹效果
      return super.applyPhysicsToUserOffset(position, offset);
    }
  }
}
