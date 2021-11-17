import 'package:flutter/material.dart';

// AdaptiveTheme.of(context).toggleThemeMode(); метод для смены темы просто на onPreset
// AdaptiveTheme.of(context).reset(); сброс темы на тему по умолчанию
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
  //#b74093
  static const Color color1 = Color(0xFF0DCEDA);
  static const Color color2 = Color(0xFF6EF3D6);
  static const Color color3 = Color(0xFFC6FCE5);
  static const Color color4 = Color(0xFFEBFFFA);
// static const main = Color(0xffb74093);
// static const mainTWo = Color.fromRGBO(32, 32, 30, 1);
// static const mainTextColor = Color.fromRGBO(130, 133, 136, 1);
}

final myLightTheme = ThemeData.light().copyWith(
  // primaryColor: ColorsLightTheme.color1,
  //
  //
  //
  //
  //
  // // floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.black),
  //
  // //dialogBackgroundColor: Для алертдиалог?
  // // hoverColor: для подсказок в тексфилдах?
  // // hintColor:
  // // splashFactory:
  // // bottomAppBarColor: Colors.black,
  // // primaryColorLight: ColorsLightTheme.color1, // главный цвет например контейнеров, если цвет не задан???
  // // primaryTextTheme: Typography.blackCupertino,  // настройка стиля текста если он не задан явно
  //
  // // shadowColor: Colors.blue, // цвет тени
  // // buttonTheme: ButtonThemeData(buttonColor: Colors.red),
  // // visualDensity: VisualDensity()  ,// макс и мин плотность между виджетами
  // // // //https://vc.ru/design/199498-kak-sozdat-kachestvennuyu-cvetovuyu-palitru-dlya-ui
  //
  // // Работает
  //
  // dialogTheme: DialogTheme(
  //   titleTextStyle: TextStyle(color: Colors.black),
  //   contentTextStyle: TextStyle(color: Colors.black),
  // ), // настройка Алертдиалог
  //
  // progressIndicatorTheme: ProgressIndicatorThemeData(linearTrackColor: Colors.red),
  //
  // checkboxTheme: CheckboxThemeData(), // если он будет, то настроить
  //
  //
  // canvasColor: ColorsLightTheme.color4, // цвет Driwer + всплывающее меню
  // splashColor: Colors.grey[200], // цвет сплеша глобальный
  // dividerColor: Colors.grey, // цвет divider
  // iconTheme: IconThemeData(
  //   color: ColorsLightTheme.color1,
  // ), // настройка иконок
  // textTheme: TextTheme(
  //     headline1: TextStyle(color: Colors.red),
  //     // Чрезвычайно большой текст.
  //     headline3: TextStyle(color: Colors.red),
  //     // Очень большой текст.
  //     headline4: TextStyle(color: Colors.red),
  //     // Большой текст.
  //     headline5: TextStyle(color: Colors.red),
  //     // Используется для большого текста в диалоговых окнах (например, месяц и год в диалоговом окне, показанном showDatePicker).
  //
  //     bodyText1: TextStyle(color: Colors.green),
  //     // Используется для выделения текста, который в противном случае был бы bodyText2
  //     bodyText2: TextStyle(color: Colors.black),
  //     // цвет body текста, Стиль текста по умолчанию для материала
  //
  //     subtitle1: TextStyle(color: Colors.black),
  //     // цвет ввода в текст филд, Используется для основного текста в списках (например, ListTile.title).
  //     subtitle2: TextStyle(color: Colors.deepOrangeAccent),
  //     // Для текста со средним акцентом, который немного меньше, чем подзаголовок1.
  //
  //     button: TextStyle(color: Colors.amber),
  //     // Используется для текста на кнопках ElevatedButton, TextButton и OutlinedButton.
  //     caption: TextStyle(color: Colors.green),
  //     // Используется для вспомогательного текста, связанного с изображениями.
  //     overline: TextStyle(
  //         color: Colors
  //             .green) // Самый маленький стиль.Обычно используется для подписей или для введения (большего) заголовка.
  //
  //     ), // настройка цвета текста
  // inputDecorationTheme: InputDecorationTheme(
  //
  //   filled: true,
  //   fillColor: Colors.white,
  //   // цвет фона
  //   isCollapsed: true,
  //   contentPadding: const EdgeInsets.all(15),
  //   hintStyle: const TextStyle(color: Colors.grey),
  //
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: BorderSide(width: 1.0, color: Colors.white),
  //   ),
  //
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(
  //       width: 2.0,
  //       color: Colors.blue,
  //     ),
  //   ),
  // ),  // настройка текст филд
  // textButtonTheme: TextButtonThemeData(
  //   style: ButtonStyle(
  //     textStyle: MaterialStateProperty.all(
  //       const TextStyle(color: Colors.green),
  //     ),
  //     shape: MaterialStateProperty.all(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     shadowColor: MaterialStateProperty.all(Colors.grey),
  //     elevation: MaterialStateProperty.all(5),
  //     foregroundColor: MaterialStateProperty.all(Colors.blue),
  //     backgroundColor: MaterialStateProperty.all(Colors.white),
  //     overlayColor: MaterialStateProperty.all(Colors.grey),
  //   ),
  // ), // настройка текстбатон
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   backgroundColor: ColorsLightTheme.color1,
  //
  //   // либо
  //   selectedItemColor: ColorsLightTheme.color4,
  //   unselectedItemColor: ColorsLightTheme.color3,
  //   // либо
  //   selectedIconTheme: IconThemeData(
  //     color: ColorsLightTheme.color4,
  //   ),
  //   unselectedIconTheme: IconThemeData(
  //     color: ColorsLightTheme.color3,
  //   ),
  //
  //   selectedLabelStyle: TextStyle(fontSize: 12),
  //   unselectedLabelStyle: TextStyle(fontSize: 12),
  // ),// настройка BottomNavigationBarThemeData
  // appBarTheme: AppBarTheme(
  //   backgroundColor: ColorsLightTheme.color1,
  // ), // настройка аппбара
  // //AppBarTheme
  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета
