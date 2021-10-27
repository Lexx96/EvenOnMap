import 'package:flutter/material.dart';

const color = Colors.black;

final myDarkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(color: color),

  splashFactory: InkRipple.splashFactory,
); //copyWith - позволяет переопределить цвета