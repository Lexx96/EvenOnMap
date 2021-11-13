import 'package:flutter/material.dart';
// AdaptiveTheme.of(context).toggleThemeMode(); метод для смены темы просто на onPreset
// AdaptiveTheme.of(context).reset(); сброс темы на тему по умолчанию
final myLightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(color: Colors.amberAccent),
  splashColor: Colors.red,
  dividerColor: Colors.red,
  buttonTheme: ButtonThemeData(),
  visualDensity: VisualDensity()  ,// макс и мин плотность между виджетами
  textTheme: TextTheme(),
  primaryColorLight: Color(0xFF42A5F5),
  //https://vc.ru/design/199498-kak-sozdat-kachestvennuyu-cvetovuyu-palitru-dlya-ui


  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета