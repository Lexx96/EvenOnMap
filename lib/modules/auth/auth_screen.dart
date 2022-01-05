import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/modules/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/modules/license_agreement_screen/license_agreement_screen.dart';
import 'package:event_on_map/modules/userProfile/service/user_profile_service.dart';
import 'package:event_on_map/utils/custom_icons/custom_icons.dart';
import 'package:event_on_map/utils/navigation/main_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_bloc_state.dart';

/// Экран авторизации и регстрации
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late ServiceAuthBloc _bloc;
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  static const Color _whiteColor = Color(0xffffffff);

  @override
  void initState() {
    super.initState();
    _bloc = ServiceAuthBloc();
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
              _whiteColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder(
            stream: _bloc.streamController,
            builder: (BuildContext _context, AsyncSnapshot _snapshot) {
              print(_snapshot.data);

              if (_snapshot.data is LogInLoadedState) {
                Future.delayed(
                  Duration.zero,
                  () => Navigator.of(_context)
                      .pushNamed(MainNavigationRouteName.mainScreen),
                );
              }

              return Stack(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text(
                                S.of(_context).appName,
                                style: TextStyle(fontSize: 45),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(_context).size.height * 0.4,
                        width: MediaQuery.of(_context).size.width * 0.8,
                        child: Image.asset('assets/images/mapOne.png'),
                      ),
                      Column(
                        children: [
                          TextField(
                            decoration: _inputDecoration(
                              context: _context,
                              prefix: const Text('+7'),
                              snapshot: _snapshot,
                              labelText: S.of(context).phoneNumber,
                              onPressed: () {},
                            ),
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: _height * 0.03),
                          TextField(
                            decoration: _inputDecoration(
                              context: _context,
                              snapshot: _snapshot,
                              labelText: S.of(context).password,
                              onPressed: () {
                                _snapshot.data is ShowPassword
                                    ? _bloc.closePasswordBloc()
                                    : _bloc.showPasswordBloc();
                              },
                              prefixIcon: Icon(Icons.lock),
                              suffixIconOne: Icon(CustomIcons.eye),
                              suffixIconTwo: Icon(CustomIcons.eye_off),
                            ),
                            obscureText:
                                (_snapshot.data is ShowPassword) ? false : true,
                            obscuringCharacter: '*',
                            controller: _passwordController,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text(
                              S.of(_context).logInToYourAccountOrRegister,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey)),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          S.of(_context).enter,
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () =>
                            (_snapshot.data is LoadingState ||
                                    _snapshot.data is LoadingState)
                                ? null
                                : _goLogIn(_snapshot),
                      ),
                      SizedBox(
                          height: MediaQuery.of(_context).size.height * 0.01),
                      TextButton(
                        child: Text(
                          S.of(_context).registration,
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () =>
                            (_snapshot.data is LoadingState ||
                                    _snapshot.data is LoadingState)
                                ? null
                                : _goRegistration(_snapshot),
                      ),
                    ],
                  ),
                  _snapshot.data is LoadingState ||
                          _snapshot.data is LoadingState
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink(),
                  _snapshot.data is RegistrationLoadedState
                      ? LicenseAgreement(isFirstEnter: true)
                      : SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Проверка коректности логина и пароля при авторизации,
  /// авторизация ранее зарегистрированного пользователя,
  /// принимает AsyncSnapshot [_snapshot]
  void _goLogIn(AsyncSnapshot _snapshot) async {
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;

    if (_numberText.length <= 9 && _passwordText.length <= 7) {
      _showMessage(
          '${S.of(context).numberLength}\n${S.of(context).passwordLength}');
    } else if (_numberText.length <= 9) {
      _showMessage('${S.of(context).numberLength}');
    } else if (_passwordText.length <= 7) {
      _showMessage('${S.of(context).passwordLength}');
    } else {
      _bloc.loadingLogIn(_numberText, _passwordText);
      _showException(_snapshot);
      await UserProfileProvider()
          .saveUserDataInSharedPreferences(phoneNumber: _numberText);
      await WriteAndReadDataFromSecureStorage.writePhoneNumber(
          phoneNumber: _numberText);
      await WriteAndReadDataFromSecureStorage.writeUserPassword(
          password: _passwordText);
    }
  }

  /// Проверка коректности логина и пароля при регистрации,
  /// регистрация нового пользователя, принимает AsyncSnapshot [_snapshot]
  void _goRegistration(AsyncSnapshot _snapshot) async {
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;

    if (_numberText.length <= 9 && _passwordText.length <= 7) {
      _showMessage(
          '${S.of(context).numberLength}\n${S.of(context).passwordLength}');
    } else if (_numberText.length <= 9) {
      _showMessage('${S.of(context).numberLength}');
    } else if (_passwordText.length <= 7) {
      _showMessage('${S.of(context).passwordLength}');
    } else {
      _bloc.loadingRegistration(_numberText, _passwordText).whenComplete(
        () async {
          _showException(_snapshot);
          await UserProfileProvider()
              .saveUserDataInSharedPreferences(phoneNumber: _numberText);
          await WriteAndReadDataFromSecureStorage.writePhoneNumber(
              phoneNumber: _numberText);
          await WriteAndReadDataFromSecureStorage.writeUserPassword(
              password: _passwordText);
        },
      );
    }
  }

  /// Оповещение при исключении
  /// принимает AsyncSnapshot [_snapshot]
  void _showException(AsyncSnapshot _snapshot) {
    if (_snapshot.data is ErrorPassword) {
      return _showMessage(S.of(context).errorPassword);
    } else if (_snapshot.data is NotRegistered) {
      return _showMessage(S.of(context).userNotRegistered);
    } else if (_snapshot.data is UserAlreadyRegistered) {
      return _showMessage(S.of(context).userAlreadyRegistered);
    } else if (_snapshot.data is AccessTokenNotSet) {
      return _showMessage(S.of(context).errorWritingAccessToken);
    }
  }

  /// Показ уведомления пользователю, принимает сообщения  String [_message]
  void _showMessage(String _message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              '\n\n$_message',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.of(context).ok),
            ),
          ],
        );
      },
    );
  }

  /// Декорация TextField принимает BuildContext [context], AsyncSnapshot [snapshot],
  /// Function? [onPressed], Widget? [prefix], Icon? [prefixIcon],
  /// Icon? [suffixIconOne], Icon? [suffixIconTwo]
  InputDecoration _inputDecoration({
    required BuildContext context,
    required AsyncSnapshot snapshot,
    required Function? onPressed,
    required String labelText,
    Widget? prefix,
    Icon? prefixIcon,
    Icon? suffixIconOne,
    Icon? suffixIconTwo,
  }) {
    return InputDecoration(
      prefixStyle: const TextStyle(fontSize: 16),
      prefixIcon: prefixIcon ?? null,
      prefix: prefix,
      suffixIcon: suffixIconOne != null && suffixIconTwo != null
          ? IconButton(
        onPressed: () => snapshot.data is ShowPassword
            ? _bloc.closePasswordBloc()
            : _bloc.showPasswordBloc(),
        icon:
        snapshot.data is ShowPassword ? suffixIconOne : suffixIconTwo,
      )
          : null,
      contentPadding: const EdgeInsets.all(15),
      labelText: labelText,
    );
  }
}
