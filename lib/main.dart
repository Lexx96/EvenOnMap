import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/utils/navigation/main_navigation.dart';
import 'package:event_on_map/utils/themes/my_dark_theme.dart';
import 'package:event_on_map/utils/themes/my_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'generated/l10n.dart';
import 'modules/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'modules/auth/services/user_log_in/user_log_in_servise.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // говорит о там что инициализацию приложения проводить тут
  runApp(
    Home(savedThemeMode: await AdaptiveTheme.getThemeMode(), isUserAuth: await isUserAuth()),
  );
}

class Home extends StatelessWidget {
  final String? isUserAuth;
  final savedThemeMode;

  const Home({Key? key, this.savedThemeMode, this.isUserAuth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: savedThemeMode ?? AdaptiveThemeMode.system, // по умолчанию
      light: myLightTheme,
      dark: myDarkTheme,
      builder: (light, dark) =>
          RefreshConfiguration( // для обновления страницы новостей потянуть вниз
            headerBuilder: () => WaterDropHeader(), // стиль обновления
            footerBuilder: () => ClassicFooter(), // нижний индикатор ???
            headerTriggerDistance: 80.0, // высота области обновления
            maxOverScrollExtent: 100, // Максимальный диапазон перетаскивания головки
            maxUnderScrollExtent: 100, // Максимальный диапазон перетаскивания головки
            enableScrollWhenRefreshCompleted: true, // панель вкладок влево и вправо
            enableLoadingWhenFailed: true,
            //В случае сбоя загрузки пользователи по-прежнему могут запускать дополнительные нагрузки, подтягивая их жестом.
            child: MaterialApp(
              theme: light,
              darkTheme: dark,
              localizationsDelegates: const [

                /// localizations для App
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,

                /// localizations для SmartRefresher
                RefreshLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate
              ],

              supportedLocales: S.delegate.supportedLocales,
              localeResolutionCallback: (locale, supportedLocales) {
                if (locale == null) {
                  return supportedLocales.first;
                }
              },
              routes: MainNavigation().routes,
              initialRoute: isUserAuth,
            ),
          ),
    );
  }
}

/// Проверка авторизации пользователя и перенаправление на страницу регистрации или на главную страницу приложения
Future<String?> isUserAuth() async {
  final isUserLogIn = await WriteAndReadDataFromSecureStorage.readUserPhoneNumber();
  final isUserPassword = await WriteAndReadDataFromSecureStorage.readUserPassword();
  if (isUserLogIn == null || isUserPassword == null) {
    return MainNavigation().initialRouteAuth;
  } else {
    try{
      await UserLogInProvider().postUserLogIn(isUserLogIn, isUserPassword);
      return MainNavigation().initialRouteMain;
    }catch(e){
      throw Exception(e);
    }
  }
}
