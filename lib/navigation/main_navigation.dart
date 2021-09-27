import 'package:event_on_map/auth/auth_screen_widget.dart';
import 'package:event_on_map/auth_sign_in/auth_sign_up_widget.dart';
import 'package:event_on_map/change_personal_data_page/change_personal_data_page.dart';
import 'package:event_on_map/create_an_event_widget/create_an_event_widget.dart';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/map_widget/map_widget.dart';
import 'package:event_on_map/news_widget/news_widget.dart';
import 'package:event_on_map/personal_data_page/personal_data_page.dart';
import 'package:event_on_map/userProfile/user_profile_widget.dart';
import 'package:flutter/material.dart';


abstract class MainNavigationRouteName {
  static const auth = 'auth';
  static const authSignUp = 'auth/authSignUp';
  static const personalDataPage = 'personalDataPage';
  static const changePersonalDataPage = 'changePersonalDataPage';
  static const createAnEventWidget = 'createAnEventWidget';
  static const userProfile = 'userProfile';
  static const newsWidget = 'newsWidget';
  static const mapWidget = 'mapWidget';
  static const mainScreen = 'mainScreen';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => const AuthWidget(),
    MainNavigationRouteName.authSignUp: (context) => const AuthSignUpWidget(),
    MainNavigationRouteName.personalDataPage: (context) => const PersonalDataPageWidget(),
    MainNavigationRouteName.changePersonalDataPage: (context) => const ChangePersonalDataPage(),
    MainNavigationRouteName.createAnEventWidget: (context) => const CreateAnEventWidget(),
    MainNavigationRouteName.userProfile: (context) => const UserProfile(),
    MainNavigationRouteName.newsWidget: (context) => const NewsWidget(),
    MainNavigationRouteName.mapWidget: (context) => const MapWidget(),
    MainNavigationRouteName.mainScreen: (context) => const MainScreen(),
  };
}