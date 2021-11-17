import 'package:event_on_map/auth/widgets/auth_header_widget.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_api_repository.dart';
import 'package:event_on_map/auth_sign_in/main_screen_decoration.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/license_agreement_screen/license_agreement_screen.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../custom_icons_icons.dart';
import 'widgets/auth_main_image_widget.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_bloc_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  final _spinkit = SpinKitWave(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.lightBlue : Colors.white,
        ),
      );
    },
  );

  final _numberController = TextEditingController(text: '9134322000');
  final _passwordController = TextEditingController(text: 'Sex12345LK');

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
      body: MainScreenDecoration(
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
                hintText: S.of(context).phoneNumber,
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
                hintText: '     ' + S.of(context).password,
              );

              return Stack(
                children: [
                  ListView(
                    children: [
                      const AuthHeaderWidget(),
                      const AuthMainImage(),
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
                            obscureText:
                                (snapshot.data is ShowPassword) ? false : true,
                            obscuringCharacter: '*',
                            controller: _passwordController,
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
                        ),
                        onPressed: () => _goLogIn(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      TextButton(
                        child: Expanded(
                          child: Text(
                            S.of(context).registration,
                          ),
                        ),
                        onPressed: () => _goRegistration(),
                      ),
                    ],
                  ),
                  (snapshot.data is RegistrationLoadingState ||
                          snapshot.data is AuthLogInLoadingState)
                      ? Center(child: _spinkit)
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

  /// Вход уже зарегистрированного пользователя
  void _goLogIn() {
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;

    if (_numberText.length <= 9 && _passwordText.length <= 7) {
      _bloc.errorLengthLoginAndPassword();
    } else if (_numberText.length <= 9) {
      _bloc.errorLengthNumber();
    } else if (_passwordText.length <= 7) {
      _bloc.errorLengthPassword();
    } else {
      _bloc.loadingLogIn(_numberText, _passwordText);
    }
  }

  /// Регистрация нового пользователя
  void _goRegistration() {
    final _numberText = _numberController.text;
    final _passwordText = _passwordController.text;
    // print(_numberText + _passwordText);

    if (_numberText.length <= 9 && _passwordText.length <= 7) {
      _bloc.errorLengthLoginAndPassword();
    } else if (_numberText.length <= 9) {
      _bloc.errorLengthNumber();
    } else if (_passwordText.length <= 7) {
      _bloc.errorLengthPassword();
    } else {
      _bloc.loadingRegistration(_numberText, _passwordText);
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
          'Не верный пароль',
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
        )),
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
