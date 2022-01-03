import 'package:flutter/material.dart';

abstract class ColorsLightTheme {
  static const Color lightColor1 = Color(0xFFFFFFFF);
  static const Color lightColor2 = Color(0xFF0074E1);
  static const Color lightColor3 = Color(0xFF1B9CE5);
  static const Color lightColor4 = Color(0xFF6CDAEE);
}

final myLightTheme = ThemeData.light().copyWith(
  primaryColor: ColorsLightTheme.lightColor4,
  scaffoldBackgroundColor: ColorsLightTheme.lightColor1,
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsLightTheme.lightColor3,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ColorsLightTheme.lightColor3,
    selectedItemColor: ColorsLightTheme.lightColor1,
    unselectedItemColor: ColorsLightTheme.lightColor4,
    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 10),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[300],
    isCollapsed: true,
    contentPadding: const EdgeInsets.all(15),
    hintStyle: const TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1.0, color: ColorsLightTheme.lightColor4),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 2.0,
        color: ColorsLightTheme.lightColor3,
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: ColorsLightTheme.lightColor3,
    titleTextStyle: TextStyle(
      fontSize: 18,
    ),
    contentTextStyle: TextStyle(
      fontSize: 14,
    ),
  ),
  iconTheme: IconThemeData(
    color: ColorsLightTheme.lightColor2,
  ),
  canvasColor: ColorsLightTheme.lightColor1,
  splashColor: ColorsLightTheme.lightColor4,
  dividerColor: ColorsLightTheme.lightColor4,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(color: ColorsLightTheme.lightColor3),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: ColorsLightTheme.lightColor2)),
      ),
      shadowColor: MaterialStateProperty.all(Colors.grey),
      foregroundColor: MaterialStateProperty.all(ColorsLightTheme.lightColor1),
      backgroundColor: MaterialStateProperty.all(ColorsLightTheme.lightColor2),
      overlayColor: MaterialStateProperty.all(ColorsLightTheme.lightColor4),
    ),
  ),
  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета
