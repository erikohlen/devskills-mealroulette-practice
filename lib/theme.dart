import 'package:flutter/material.dart';

ThemeData mealTheme = ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
      headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(fontSize: 14),
    ),
    primarySwatch: Colors.grey,
    backgroundColor: Colors.black12);

class KColors {
  static Color offWhite = Color.fromARGB(255, 249, 249, 241);
  static Color offWhiteBright = Color.fromARGB(255, 252, 252, 248);
}
