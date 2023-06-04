import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on int {
  String formatTimestampToDateTime() {
    int timestamp = this; // 例如，假设时间戳为 1622770200

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp); // 将时间戳转换为 DateTime

    String formattedDateTime =
        DateFormat('HH:mm:ss').format(dateTime); // 格式化日期时间

    return formattedDateTime;
  }
}

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool shouldRetain;
  const PositionRetainedScrollPhysics({super.parent, this.shouldRetain = true});

  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
      shouldRetain: shouldRetain,
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;

    if (oldPosition.pixels > oldPosition.minScrollExtent &&
        diff > 0 &&
        shouldRetain) {
      return position + diff;
    } else {
      return position;
    }
  }
}
