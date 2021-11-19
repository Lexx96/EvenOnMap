import 'package:flutter/material.dart';

abstract class ColorsDarkTheme {
  static const Color darkColor1 = Color(0xFF1F2833); // главный
  static const Color darkColor2 = Color(0x800B0C10); // второстипенный
  static const Color darkColor3 = Color(0xFF0B0C10); // второстипенный
  static const Color darkColor4 = Color(0xFFC5C6C7); // текст
  static const Color darkColor5 = Color(0xFF66FCF1); // кнопки
  static const Color darkColor6 = Color(0xFF45A29E); // подсказки
}

final myDarkTheme = ThemeData.dark().copyWith(

  primaryColor: ColorsDarkTheme.darkColor1,

  scaffoldBackgroundColor: ColorsDarkTheme.darkColor1,

  appBarTheme: AppBarTheme(
    backgroundColor: ColorsDarkTheme.darkColor1,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ColorsDarkTheme.darkColor1,

    selectedItemColor: ColorsDarkTheme.darkColor5,
    unselectedItemColor: ColorsDarkTheme.darkColor6,

    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 10),
  ),

  inputDecorationTheme: InputDecorationTheme(

    filled: true,
    fillColor: ColorsDarkTheme.darkColor2,
    isCollapsed: true,
    contentPadding: const EdgeInsets.all(15),
    hintStyle: const TextStyle(color: ColorsDarkTheme.darkColor4),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1.0, color: ColorsDarkTheme.darkColor2),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 2.0,
        color: ColorsDarkTheme.darkColor5,
      ),
    ),
  ),

  dialogTheme: DialogTheme(
    backgroundColor: ColorsDarkTheme.darkColor3,
    titleTextStyle: TextStyle(
      color: ColorsDarkTheme.darkColor4,
      fontSize: 18,
    ),
    contentTextStyle: TextStyle(
      color: ColorsDarkTheme.darkColor4,
      fontSize: 14,
    ),
  ),

  canvasColor: ColorsDarkTheme.darkColor1,

  splashColor: ColorsDarkTheme.darkColor6,

  dividerColor: ColorsDarkTheme.darkColor5,

  iconTheme: IconThemeData(
    color: ColorsDarkTheme.darkColor5,
  ),

  textTheme: TextTheme(

      bodyText2: TextStyle(color: ColorsDarkTheme.darkColor4),
      subtitle1: TextStyle(color: ColorsDarkTheme.darkColor4),
      button: TextStyle(color: ColorsDarkTheme.darkColor5),
      ),



  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(color: ColorsDarkTheme.darkColor4),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: ColorsDarkTheme.darkColor5)),
      ),
      shadowColor: MaterialStateProperty.all(Colors.grey),
      foregroundColor: MaterialStateProperty.all(ColorsDarkTheme.darkColor5),
      backgroundColor: MaterialStateProperty.all(ColorsDarkTheme.darkColor1),
      overlayColor: MaterialStateProperty.all(ColorsDarkTheme.darkColor6),
    ),
  ),

  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета
