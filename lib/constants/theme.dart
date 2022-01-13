import 'package:flutter/material.dart';

ThemeData vgwTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: vgwBlue,
  colorScheme: ColorScheme(
      primary: vgwBlue,
      primaryVariant: vgwBlue,
      secondary: vgwYellow,
      secondaryVariant: vgwYellow,
      surface: const Color(0xff09003F),
      onBackground: Colors.white,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      error: Colors.red,
      brightness: Brightness.light,
      background: const Color(0xff09003F)),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2),
    bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2),
    headline1: TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2),
    headline2: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2),
    headline3: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2),
  ),
);

MaterialColor vgwBlue = MaterialColor(0xFF00B2FF, colorVGWBlue);
Map<int, Color> colorVGWBlue = {
  400: const Color.fromRGBO(0, 178, 255, 1),
};

MaterialColor vgwYellow = MaterialColor(0xFFFFEC44, colorVGWYellow);
Map<int, Color> colorVGWYellow = {
  400: const Color.fromRGBO(255, 236, 68, 1),
};
