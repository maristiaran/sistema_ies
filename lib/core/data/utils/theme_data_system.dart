import 'package:flutter/material.dart';

mixin ThemeDataSW implements ThemeData {
  static final themeDataSW = ThemeData(
    brightness: Brightness.light,
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 73, 145, 254)),
    colorScheme: ColorScheme.fromSeed(
        primary: const Color.fromARGB(255, 81, 126, 240),
        secondary: const Color.fromARGB(255, 63, 63, 63),
        tertiary: const Color.fromARGB(255, 198, 198, 198),
        error: const Color.fromARGB(255, 182, 27, 27),
        background: const Color.fromARGB(255, 255, 255, 255),
        brightness: Brightness.light,
        seedColor: const Color.fromARGB(255, 81, 126, 240)),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 63, 63, 63)),
      headline2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 81, 126, 240)),
      headline3: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Roboto',
          color: Color.fromARGB(255, 255, 255, 255)),
      bodyText2: TextStyle(fontSize: 14.0),
    ),
  );
}
