import 'package:flutter/material.dart';

class ApplicationTheme {
  bool isDark;
  Color _primary = const Color(0xff263c7a);
  Color _secondary = const Color(0xfffca311);

  ApplicationTheme({@required this.isDark});

  ThemeData get themeData {
    ColorScheme scheme;

    if (isDark) {
      scheme = ColorScheme.dark(
        primary: _secondary,
        secondary: _secondary,
        onSecondary: Colors.black,
        onPrimary: Colors.white,
        primaryVariant: const Color(0xff00174d),
        secondaryVariant: const Color(0xffc37400),
      );
    } else {
      scheme = ColorScheme.light(
        primary: _primary,
        secondary: const Color(0xffffd44f),
        onSecondary: Colors.black,
        onPrimary: Colors.white,
        primaryVariant: const Color(0xff5866aa),
        secondaryVariant: const Color(0xffffd44f),
      );
    }

    return ThemeData.from(colorScheme: scheme);
  }
}
