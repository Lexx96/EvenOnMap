import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/themes/my_dark_theme.dart';
import 'package:event_on_map/themes/my_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import '../navigation/main_navigation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // говорит о там что инициализацию приложения проводить тут
  runApp(
    Home(
      savedThemeMode: await AdaptiveTheme.getThemeMode(), // что за текущий режим?
    ),
  );
}

class Home extends StatelessWidget {
  final savedThemeMode;
  const Home({Key? key, this.savedThemeMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: savedThemeMode ?? AdaptiveThemeMode.system, // по умолчанию
      light: myLightTheme,
      dark: myDarkTheme,
      builder: (light, dark) => MaterialApp(
        //splashFactory: InkRipple.splashFactory,
        theme: light,
        darkTheme: dark,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) {
            return supportedLocales.first;
          }
        },
        routes: MainNavigation().routes,
        initialRoute: MainNavigation().initialRoute,
      ),
    );
  }
}
