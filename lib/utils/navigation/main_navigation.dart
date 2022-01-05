import 'package:event_on_map/modules/about_application/about_application_screen.dart';
import 'package:event_on_map/modules/about_developer/abaut_developer_screen.dart';
import 'package:event_on_map/modules/auth/auth_screen.dart';
import 'package:event_on_map/modules/change_personal_data/change_personal_data_screen.dart';
import 'package:event_on_map/modules/create_event/create_event_screen.dart';
import 'package:event_on_map/modules/decoration/decoration_screen.dart';
import 'package:event_on_map/modules/feedback/feedback_screen.dart';
import 'package:event_on_map/modules/license_agreement_screen/license_agreement_screen.dart';
import 'package:event_on_map/modules/main_screen/main_screen.dart';
import 'package:event_on_map/modules/map_widget/map_screen.dart';
import 'package:event_on_map/modules/news_page/news_screen.dart';
import 'package:event_on_map/modules/userProfile/user_profile_screen.dart';
import 'package:flutter/material.dart';


abstract class MainNavigationRouteName {
  static const auth = 'auth';
  static const authSignUp = 'auth/authSignUp';
  static const changePersonalDataPage = 'changePersonalDataPage';
  static const createAnEventWidget = 'createAnEventWidget';
  static const userProfile = 'userProfile';
  static const newsWidget = 'newsWidget';
  static const mapWidget = 'mapWidget';
  static const mainScreen = 'mainScreen';
  static const licenseAgreement = 'aboutTheApp';
  static const aboutApplication = 'aboutApplication';
  static const feedbackPage = 'feedbackPage';
  static const aboutDeveloper = 'aboutDeveloper';
  static const decorationPage = 'decorationPage';
  static const createEventMapWidget = 'createEventMapWidget';
}

class MainNavigation {
  final initialRouteAuth = MainNavigationRouteName.auth;
  final initialRouteMain = MainNavigationRouteName.mainScreen;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.auth: (context) => const AuthScreen(),
    MainNavigationRouteName.changePersonalDataPage: (context) => ChangePersonalDataPage(),
    MainNavigationRouteName.createAnEventWidget: (context) => const CreateEventWidget(),
    MainNavigationRouteName.userProfile: (context) => const UserProfilePage(),
    MainNavigationRouteName.newsWidget: (context) => NewsPage(),
    MainNavigationRouteName.mapWidget: (context) => MapWidget(),
    MainNavigationRouteName.mainScreen: (context) => MainScreen(0),
    MainNavigationRouteName.licenseAgreement: (context) => LicenseAgreement(isFirstEnter: false,),
    MainNavigationRouteName.aboutApplication: (context) => const AboutApplication(),
    MainNavigationRouteName.feedbackPage: (context) => const FeedbackPage(),
    MainNavigationRouteName.aboutDeveloper: (context) => const AboutDeveloper(),
    MainNavigationRouteName.decorationPage: (context) => const DecorationPage(),
  };
}