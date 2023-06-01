import 'package:flutter/material.dart';

class ThemeProvider {
  static Color backgroundWhite = "#F7F7F9".toColor();
  static Color textActivate = "#292941".toColor();
  static Color textSecondary = "#8A8CA9".toColor();
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}