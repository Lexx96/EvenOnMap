import 'package:flutter/material.dart';
// AdaptiveTheme.of(context).toggleThemeMode(); метод для смены темы просто на onPreset
// AdaptiveTheme.of(context).reset(); сброс темы на тему по умолчанию
final myLightTheme = ThemeData.light().copyWith(
appBarTheme: AppBarTheme(color: Colors.green),






  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета