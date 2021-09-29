import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
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
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (locale,supportedLocales) {
        if(locale == null){
          return supportedLocales.first;
        }
      },
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
      ),
      routes: MainNavigation().routes,
      initialRoute: MainNavigation().initialRoute,
    );
  }
}
