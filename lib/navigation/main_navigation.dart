
import 'package:event_on_map/auth/auth_screen.dart';
import 'package:event_on_map/change_personal_data_page/change_personal_data_page.dart';
import 'package:event_on_map/create_event/create_event_screen.dart';
import 'package:event_on_map/license_agreement_screen/license_agreement_screen.dart';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/map_widget/map_widget.dart';
import 'package:event_on_map/news_widget/news_pages.dart';
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
  static const licenseAgreement = 'aboutTheApp';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => const AuthWidget(),
    //MainNavigationRouteName.authSignUp: (context) => const AuthSignUpWidget(),
    MainNavigationRouteName.personalDataPage: (context) => const PersonalDataPageWidget(),
    MainNavigationRouteName.changePersonalDataPage: (context) => const ChangePersonalDataPage(),
    MainNavigationRouteName.createAnEventWidget: (context) => const CreateEventWidget(),
    MainNavigationRouteName.userProfile: (context) => const UserProfilePage(),
    MainNavigationRouteName.newsWidget: (context) => const NewsWidget(),
    MainNavigationRouteName.mapWidget: (context) => const MapWidget(),
    MainNavigationRouteName.mainScreen: (context) => const MainScreen(),
    MainNavigationRouteName.licenseAgreement: (context) => const LicenseAgreement(),
  };
}