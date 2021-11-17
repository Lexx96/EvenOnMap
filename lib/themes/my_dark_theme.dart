import 'package:flutter/material.dart';

abstract class ColorsDarkTheme {
  /*
  Hexadecimal opacity values
100% — FF

95% — F2

90% — E6

85% — D9

80% — CC

75% — BF

70% — B3

65% — A6

60% — 99

55% — 8C

50% — 80

45% — 73

40% — 66

35% — 59

30% — 4D

25% — 40

20% — 33

15% — 26
   */
  //#b74093
  static const Color color1 = Color(0xFF2e2f33);
  static const Color color2 = Color(0xFF7cacf8);
  static const Color color3 = Color(0xFFc1c2c5);
  // static const Color color4 = Color(0xFFEBFFFA);
  // static const main = Color(0xffb74093);
  // static const mainTWo = Color.fromRGBO(32, 32, 30, 1);
  // static const mainTextColor = Color.fromRGBO(130, 133, 136, 1);
}


final myDarkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(backgroundColor: ColorsDarkTheme.color1),




  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(color: Colors.grey),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.white),
      elevation: MaterialStateProperty.all(1),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.grey),
      overlayColor: MaterialStateProperty.all(Colors.white),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ColorsDarkTheme.color1,

    // либо
    selectedItemColor: ColorsDarkTheme.color2,
    unselectedItemColor: ColorsDarkTheme.color3,
    // либо
    selectedIconTheme: IconThemeData(
      color: ColorsDarkTheme.color2,
    ),
    unselectedIconTheme: IconThemeData(
      color: ColorsDarkTheme.color3,
    ),

    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 8),
  ),// настройка BottomNavigationBarThemeData

  inputDecorationTheme: InputDecorationTheme(

    filled: true,
    fillColor: ColorsDarkTheme.color3,
    // цвет фона
    isCollapsed: true,
    contentPadding: const EdgeInsets.all(15),
    hintStyle: const TextStyle(color: Colors.grey),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1.0, color: Colors.white),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 2.0,
        color: Colors.blue,
      ),
    ),
  ),

  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета