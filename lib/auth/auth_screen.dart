import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_api_repository.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/license_agreement_screen/license_agreement_screen.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom_icons_icons.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_bloc_state.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() =>
      _AuthWidgetState(UserRegistrationRepository(), UserLogInRepository());
}

class _AuthWidgetState extends State<AuthWidget> {
  _AuthWidgetState(this._repository, this._authLogInRepository);

  late ServiceAuthBloc _bloc;
  late final UserRegistrationRepository _repository;
  late final UserLogInRepository _authLogInRepository;
  final _textStyle = TextStyle(fontSize: 16);

  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ServiceAuthBloc(
      _repository,
      _authLogInRepository,
    );
    _bloc.emptyState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: [
              Color(0xffffffff),
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
            stream: _bloc.streamController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is AuthLogInLoadedState) {
                Future.delayed(
                  Duration.zero,
                  () => Navigator.of(context)
                      .pushNamed(MainNavigationRouteName.mainScreen),
                );
              }

              InputDecoration _inputDecorationPhoneNumber = InputDecoration(
                prefix: const Text('+7'),
                prefixStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(
                  Icons.phone,
                ),
                labelText: S.of(context).phoneNumber,
              );

              InputDecoration _inputDecorationPassword = InputDecoration(
                prefixStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  onPressed: () => (snapshot.data is ShowPassword)
                      ? _bloc.closePasswordBloc()
                      : _bloc.showPasswordBloc(),
                  icon: (snapshot.data is ShowPassword)
                      ? Icon(CustomIcons.eye)
                      : Icon(CustomIcons.eye_off),
                ),
                contentPadding: const EdgeInsets.all(15),
                labelText: S.of(context).password,
              );

              return Stack(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: const Text(
                                'EventOnMap',
                                style: TextStyle(fontSize: 45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Image(
                          image: NetworkImage(
                              'https://static.tildacdn.com/tild3830-6230-4265-a638-393035353836/itinerairepngcartede.png'),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: _height * 0.01, bottom: _height * 0.01),
                            child: _showNumberText(snapshot),
                          ),
                          TextField(
                            decoration: _inputDecorationPhoneNumber,
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: _height * 0.02),
                          _showPasswordText(snapshot),
                          SizedBox(height: _height * 0.01),
                          TextField(
                            decoration: _inputDecorationPassword,
                            obscureText: (snapshot.data is ShowPassword) ? false : true,
                            obscuringCharacter: '*',
                            controller: _passwordController,
                            onEditingComplete: () => TextInput.finishAutofillContext(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text(
                              S.of(context).logInToYourAccountOrRegister,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey)),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          S.of(context).enter,
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () =>
                            (snapshot.data is RegistrationLoadingState ||
                                    snapshot.data is AuthLogInLoadingState)
                                ? null
                                : _goLogIn(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      TextButton(
                        child: Text(
                          S.of(context).registration,
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () =>
                            (snapshot.data is RegistrationLoadingState ||
                                    snapshot.data is AuthLogInLoadingState)
                                ? null
                                : _goRegistration(),
                      ),
                    ],
                  ),
                  (snapshot.data is RegistrationLoadingState ||
                          snapshot.data is AuthLogInLoadingState)
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink(),
                  _showException(snapshot),
                  (snapshot.data is RegistrationLoadedState)
                      ? Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: LicenseAgreement(),
                        )
                      : SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // при обновлении страницы , после выхода из уч зап само по себе приходит состояние и если в техтфилде есть логин и пароль он входит
  /// Авторизация ранее зарегистрированного пользователя
  void _goLogIn() async {
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;

    if (_numberText.length <= 9 && _passwordText.length <= 7) {
      _bloc.errorLengthLoginAndPassword();
    } else if (_numberText.length <= 9) {
      _bloc.errorLengthNumber();
    } else if (_passwordText.length <= 7) {
      _bloc.errorLengthPassword();
    } else {
      _bloc.loadingLogIn(_numberText, _passwordText).whenComplete(
        () async {
          await WriteAndReadDataFromSecureStorage.writeUserLogIn(logIn: _numberText);
          await WriteAndReadDataFromSecureStorage.writeUserPassword(password: _passwordText);
        },
      );
    }
  }

  /// Регистрация нового пользователя
  void _goRegistration() async {
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;

    if (_numberText.length <= 9 && _passwordText.length <= 7) {
      _bloc.errorLengthLoginAndPassword();
    } else if (_numberText.length <= 9) {
      _bloc.errorLengthNumber();
    } else if (_passwordText.length <= 7) {
      _bloc.errorLengthPassword();
    } else {
      _bloc.loadingRegistration(_numberText, _passwordText).whenComplete(() async{
        await WriteAndReadDataFromSecureStorage.writeUserLogIn(logIn: _numberText);
        await WriteAndReadDataFromSecureStorage.writeUserPassword(password: _passwordText);
      },
      );
    }
  }

  /// Оповещение при недостаточном колличестве знаков в номере
  Text _showNumberText(AsyncSnapshot snapshot) {
    return (snapshot.data is ErrorLengthNumber) ||
            (snapshot.data is ErrorLengthLoginAndPassword)
        ? Text(
            'Номер должен содержать 11 знаков',
            style: TextStyle(color: Colors.red, fontSize: 16),
          )
        : Text(S.of(context).enterYourPhoneNumber, style: _textStyle);
  }

  /// Оповещение при недостаточном колличестве знаков в пароле
  Text _showPasswordText(AsyncSnapshot snapshot) {
    return (snapshot.data is ErrorLengthPassword) ||
            (snapshot.data is ErrorLengthLoginAndPassword)
        ? Text(
            'Пароль должен содержать 8 знаков и более',
            style: TextStyle(color: Colors.red, fontSize: 16),
          )
        : Text(S.of(context).enterThePassword, style: _textStyle);
  }

  /// Оповещение при исключении
  Widget _showException(AsyncSnapshot snapshot) {
    if (snapshot.data is ErrorPassword) {
      return AlertDialog(
        title: Center(
            child: Text(
          'Неверный пароль',
        )),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyState(),
            child: Text('OK'),
          )
        ],
      );
    } else if (snapshot.data is NotRegistered) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Пользователь не зарегистрирован',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyState(),
            child: Text('OK'),
          )
        ],
      );
    } else if (snapshot.data is UserAlreadyRegistered) {
      return AlertDialog(
        title: Center(
            child: Text(
          'Пользователь уже зарегистрирован',
        )),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyState(),
            child: Text('OK'),
          )
        ],
      );
    } else if (snapshot.data is AccessTokenNotSet) {
      return AlertDialog(
        title: Center(
            child: Text(
          'Ошибка записи AccessToken',
        )),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyState(),
            child: Text('OK'),
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
