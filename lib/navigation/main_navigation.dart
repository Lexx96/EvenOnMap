import 'package:event_on_map/auth/auth_screen_widget.dart';
import 'package:event_on_map/auth_sign_in/auth_sign_up_widget.dart';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/personal_data_page/personal_data_page.dart';
import 'package:flutter/material.dart';


abstract class MainNavigationRouteName {
  static const auth = 'auth';
  static const authSignUp = 'auth/authSignUp';
  static const mainScreen = 'mainScreen';
  static const personalDataPage = 'personalDataPage';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => const AuthWidget(),
    MainNavigationRouteName.authSignUp: (context) => const AuthSignUpWidget(),
    MainNavigationRouteName.mainScreen: (context) => const MainScreen(),
    MainNavigationRouteName.personalDataPage: (context) => const PersonalDataPage(),
  };
}