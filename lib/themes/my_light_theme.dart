import 'package:flutter/material.dart';

abstract class ColorsLightTheme {
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
  static const Color lightColor1 = Color(0xFFFFFFFF);
  static const Color lightColor2 = Color(0xFF0074E1);
  static const Color lightColor3 = Color(0xFF1B9CE5);
  static const Color lightColor4 = Color(0xFF6CDAEE);
  static const Color lightColor5 = Color(0xFFF79E02);
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

  iconTheme: IconThemeData(
    color: ColorsLightTheme.lightColor2,
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(

      textStyle: MaterialStateProperty.all(
        const TextStyle(color: ColorsLightTheme.lightColor3),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: ColorsLightTheme.lightColor2)
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.grey),
      foregroundColor: MaterialStateProperty.all(ColorsLightTheme.lightColor1),
      backgroundColor: MaterialStateProperty.all(ColorsLightTheme.lightColor2),
      overlayColor: MaterialStateProperty.all(ColorsLightTheme.lightColor4),
    ),
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
    titleTextStyle: TextStyle(fontSize: 18,),
    contentTextStyle: TextStyle(fontSize: 14,),
  ), // настройка Алертдиалог

  canvasColor: ColorsLightTheme.lightColor1, // цвет Driwer + всплывающее меню
  //
  splashColor: ColorsLightTheme.lightColor4, // цвет сплеша глобальный
  //
  dividerColor: ColorsLightTheme.lightColor4, // цвет divider
  //
// настройка иконок
  //
  // textTheme: TextTheme(
  //   // headline1: TextStyle(color: Colors.red),
  //   // Чрезвычайно большой текст.
  //   // headline3: TextStyle(color: Colors.red),
  //   // Очень большой текст.
  //   // headline4: TextStyle(color: Colors.red),
  //   // Большой текст.
  //   // headline5: TextStyle(color: Colors.red),
  //   // Используется для большого текста в диалоговых окнах (например, месяц и год в диалоговом окне, показанном showDatePicker).
  //
  //   // bodyText1: TextStyle(color: Colors.green),
  //   // Используется для выделения текста, который в противном случае был бы bodyText2
  //     bodyText2: TextStyle(color: ColorsDarkTheme.text),
  //     // цвет body текста, Стиль текста по умолчанию для материала
  //
  //     subtitle1: TextStyle(color: ColorsDarkTheme.text),
  //     // цвет ввода в текст филд, Используется для основного текста в списках (например, ListTile.title).
  //     subtitle2: TextStyle(color: Colors.red),
  //     // Для текста со средним акцентом, который немного меньше, чем подзаголовок1.
  //
  //     button: TextStyle(color: ColorsDarkTheme.buttons),
  //     // Используется для текста на кнопках ElevatedButton, TextButton и OutlinedButton.
  //     // caption: TextStyle(color: Colors.green),
  //     // Используется для вспомогательного текста, связанного с изображениями.
  //     overline: TextStyle(
  //         color: Colors
  //             .green) // Самый маленький стиль.Обычно используется для подписей или для введения (большего) заголовка.
  //
  // ), // настройка цвета текста
  //

  //


  splashFactory: InkRipple.splashFactory,

); //copyWith - позволяет переопределить цвета
