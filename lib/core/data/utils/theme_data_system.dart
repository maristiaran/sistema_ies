import 'package:flutter/material.dart';

mixin ThemeDataSW implements ThemeData {
  static final themeDataSW = ThemeData(
    brightness: Brightness.light,
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 73, 145, 254)),
    colorScheme: ColorScheme.fromSeed(
        outline: const Color.fromARGB(255, 27, 182, 61),
        primary: const Color.fromARGB(255, 81, 126, 240),
        secondary: const Color.fromARGB(255, 63, 63, 63),
        tertiary: const Color.fromARGB(255, 198, 198, 198),
        error: const Color.fromARGB(255, 182, 27, 27),
        background: const Color.fromARGB(255, 255, 255, 255),
        brightness: Brightness.light,
        seedColor: const Color.fromARGB(255, 81, 126, 240)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 63, 63, 63)),
      displayMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 81, 126, 240)),
      displaySmall: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Roboto',
          color: Color.fromARGB(255, 255, 255, 255)),
      bodyLarge: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Roboto',
          color: Color.fromARGB(255, 28, 28, 28)),
      bodyMedium: TextStyle(fontSize: 14.0),
    ),
  );
}
