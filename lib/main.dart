import 'package:flutter/material.dart';
import 'navigation/main_navigation.dart';

/*
Локазизация приложения
Темы приложения
DataBase
Ргистрация
Авторизация
Профиль()
 */

void main() {
  runApp(Home());
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      routes: MainNavigation().routes,
      initialRoute: MainNavigation().initialRoute,
    );
  }
}
