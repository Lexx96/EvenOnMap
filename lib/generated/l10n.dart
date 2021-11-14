// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `EventOnMap`
  String get appName {
    return Intl.message(
      'EventOnMap',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter the password`
  String get enterThePassword {
    return Intl.message(
      'Enter the password',
      name: 'enterThePassword',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your account or register`
  String get logInToYourAccountOrRegister {
    return Intl.message(
      'Log in to your account or register',
      name: 'logInToYourAccountOrRegister',
      desc: '',
      args: [],
    );
  }

  /// `register`
  String get register {
    return Intl.message(
      'register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation code`
  String get confirmationCode {
    return Intl.message(
      'Confirmation code',
      name: 'confirmationCode',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `By clicking the 'Register' button, I confirm that I have read the personal data processing policy`
  String get license {
    return Intl.message(
      'By clicking the \'Register\' button, I confirm that I have read the personal data processing policy',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `Send verification code`
  String get sendVerificationCode {
    return Intl.message(
      'Send verification code',
      name: 'sendVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the number and password:`
  String get enterTheNumber {
    return Intl.message(
      'Enter the number and password:',
      name: 'enterTheNumber',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Hometown`
  String get hometown {
    return Intl.message(
      'Hometown',
      name: 'hometown',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get aboutMe {
    return Intl.message(
      'About me',
      name: 'aboutMe',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `User's nickname`
  String get userNickname {
    return Intl.message(
      'User\'s nickname',
      name: 'userNickname',
      desc: '',
      args: [],
    );
  }

  /// `More detailed ...`
  String get inMoreDetail {
    return Intl.message(
      'More detailed ...',
      name: 'inMoreDetail',
      desc: '',
      args: [],
    );
  }

  /// `minutes ago`
  String get minutesAgo {
    return Intl.message(
      'minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [],
    );
  }

  /// `was online`
  String get wasOnline {
    return Intl.message(
      'was online',
      name: 'wasOnline',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basicInformation {
    return Intl.message(
      'Basic Information',
      name: 'basicInformation',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Information`
  String get detailedInformation {
    return Intl.message(
      'Detailed Information',
      name: 'detailedInformation',
      desc: '',
      args: [],
    );
  }

  /// `My likes`
  String get myLikes {
    return Intl.message(
      'My likes',
      name: 'myLikes',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `My answers`
  String get myAnswers {
    return Intl.message(
      'My answers',
      name: 'myAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Novokuznetsk`
  String get novokuznetsk {
    return Intl.message(
      'Novokuznetsk',
      name: 'novokuznetsk',
      desc: '',
      args: [],
    );
  }

  /// `City of stay`
  String get cityOfStay {
    return Intl.message(
      'City of stay',
      name: 'cityOfStay',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Name of the educational institution`
  String get nameOfTheEducationalInstitution {
    return Intl.message(
      'Name of the educational institution',
      name: 'nameOfTheEducationalInstitution',
      desc: '',
      args: [],
    );
  }

  /// `Information about yourself in a free form`
  String get informationAboutYourselfInAFreeForm {
    return Intl.message(
      'Information about yourself in a free form',
      name: 'informationAboutYourselfInAFreeForm',
      desc: '',
      args: [],
    );
  }

  /// `Available to everyone`
  String get availableToEveryone {
    return Intl.message(
      'Available to everyone',
      name: 'availableToEveryone',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Record`
  String get record {
    return Intl.message(
      'Record',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Place of study`
  String get placeOfStudy {
    return Intl.message(
      'Place of study',
      name: 'placeOfStudy',
      desc: '',
      args: [],
    );
  }

  /// `Place of work`
  String get placeOfWork {
    return Intl.message(
      'Place of work',
      name: 'placeOfWork',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get friends {
    return Intl.message(
      'Friends',
      name: 'friends',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get mail {
    return Intl.message(
      'Mail',
      name: 'mail',
      desc: '',
      args: [],
    );
  }

  /// `About the app`
  String get aboutTheApp {
    return Intl.message(
      'About the app',
      name: 'aboutTheApp',
      desc: '',
      args: [],
    );
  }

  /// `License Agreement`
  String get licenseAgreement {
    return Intl.message(
      'License Agreement',
      name: 'licenseAgreement',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
