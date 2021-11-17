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
  static const Color main = Color(0xFF1F2833); // главный
  static const Color second = Color(0x800B0C10); // второстипенный
  static const Color second1 = Color(0xFF0B0C10); // второстипенный
  static const Color text = Color(0xFFC5C6C7); // текст
  static const Color buttons = Color(0xFF66FCF1); // кнопки
  static const Color hints = Color(0xFF45A29E); // подсказки
  // static const main = Color(0xffb74093);
  // static const mainTWo = Color.fromRGBO(32, 32, 30, 1);
  // static const mainTextColor = Color.fromRGBO(130, 133, 136, 1);
}


 final myDarkTheme = ThemeData.dark().copyWith(
//   appBarTheme: AppBarTheme(backgroundColor: ColorsDarkTheme.color1),
//
//
//
//
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       textStyle: MaterialStateProperty.all(
//         const TextStyle(color: Colors.grey),
//       ),
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       shadowColor: MaterialStateProperty.all(Colors.white),
//       elevation: MaterialStateProperty.all(1),
//       foregroundColor: MaterialStateProperty.all(Colors.white),
//       backgroundColor: MaterialStateProperty.all(Colors.grey),
//       overlayColor: MaterialStateProperty.all(Colors.white),
//     ),
//   ),
//
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ColorsDarkTheme.main,


    // либо
    selectedItemColor: ColorsDarkTheme.buttons,
    unselectedItemColor: ColorsDarkTheme.second,
    // либо
    // selectedIconTheme: IconThemeData(
    //   color: ColorsDarkTheme.color4,
    // ),
    // unselectedIconTheme: IconThemeData(
    //   color: ColorsDarkTheme.color2,
    // ),

    selectedLabelStyle: TextStyle(fontSize: 10),
    unselectedLabelStyle: TextStyle(fontSize: 10),
  ),// настройка BottomNavigationBarThemeData
//
  inputDecorationTheme: InputDecorationTheme(

    filled: true,
    fillColor: ColorsDarkTheme.second,
    // цвет фона
    isCollapsed: true,
    contentPadding: const EdgeInsets.all(15),
    hintStyle: const TextStyle(color: ColorsDarkTheme.text),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1.0, color: ColorsDarkTheme.second),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 2.0,
        color: ColorsDarkTheme.buttons,
      ),
    ),
  ),

   dialogTheme: DialogTheme(
     backgroundColor: ColorsDarkTheme.main,
     titleTextStyle: TextStyle(color: ColorsDarkTheme.text, fontSize: 18,),
     contentTextStyle: TextStyle(color: ColorsDarkTheme.text, fontSize: 16,),
   ), // настройка Алертдиалог

   canvasColor: ColorsDarkTheme.main, // цвет Driwer + всплывающее меню

   splashColor: ColorsDarkTheme.second, // цвет сплеша глобальный

   dividerColor: ColorsDarkTheme.buttons, // цвет divider

   iconTheme: IconThemeData(
     color: ColorsDarkTheme.hints,
   ), // настройка иконок


   textTheme: TextTheme(
       // headline1: TextStyle(color: Colors.red),
       // Чрезвычайно большой текст.
       // headline3: TextStyle(color: Colors.red),
       // Очень большой текст.
       // headline4: TextStyle(color: Colors.red),
       // Большой текст.
       // headline5: TextStyle(color: Colors.red),
       // Используется для большого текста в диалоговых окнах (например, месяц и год в диалоговом окне, показанном showDatePicker).

       // bodyText1: TextStyle(color: Colors.green),
       // Используется для выделения текста, который в противном случае был бы bodyText2
       bodyText2: TextStyle(color: ColorsDarkTheme.text),
       // цвет body текста, Стиль текста по умолчанию для материала

       subtitle1: TextStyle(color: ColorsDarkTheme.text),
       // цвет ввода в текст филд, Используется для основного текста в списках (например, ListTile.title).
       subtitle2: TextStyle(color: Colors.red),
       // Для текста со средним акцентом, который немного меньше, чем подзаголовок1.

       button: TextStyle(color: ColorsDarkTheme.buttons),
       // Используется для текста на кнопках ElevatedButton, TextButton и OutlinedButton.
       // caption: TextStyle(color: Colors.green),
       // Используется для вспомогательного текста, связанного с изображениями.
       overline: TextStyle(
           color: Colors
               .green) // Самый маленький стиль.Обычно используется для подписей или для введения (большего) заголовка.

       ), // настройка цвета текста

   appBarTheme: AppBarTheme(
     backgroundColor: ColorsDarkTheme.main,
   ), // настройка аппбара

   textButtonTheme: TextButtonThemeData(
     style: ButtonStyle(
       textStyle: MaterialStateProperty.all(
         const TextStyle(color: ColorsDarkTheme.text),
       ),
       shape: MaterialStateProperty.all(
         RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10),
         ),
       ),
       shadowColor: MaterialStateProperty.all(Colors.grey),

       foregroundColor: MaterialStateProperty.all(Colors.blue),
       backgroundColor: MaterialStateProperty.all(ColorsDarkTheme.second), // меняет иконку добавления фото
       overlayColor: MaterialStateProperty.all(ColorsDarkTheme.hints),
     ),
   ), // настройка текстбатон

  splashFactory: InkRipple.splashFactory,


); //copyWith - позволяет переопределить цвета