import 'package:flutter/material.dart';

class ApplicationTheme {
  static ThemeData themeData(bool isDark) {
    ColorScheme scheme;

    if (isDark) {
      scheme = ColorScheme.dark(
        primary: const Color(0xfffca311),
        secondary: const Color(0xfffca311),
      );
    } else {
      scheme = ColorScheme.light(
        primary: const Color(0xff263c7a),
        secondary: const Color(0xfffca311),
      );
    }

    return ThemeData.from(colorScheme: scheme);
  }
}
