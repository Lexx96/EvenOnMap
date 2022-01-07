import 'dart:async';
import 'package:event_on_map/modules/auth/services/user_log_in/user_log_in_servise.dart';
import 'package:event_on_map/modules/auth/services/user_registration/user_registration_servise.dart';
import 'auth_bloc_state.dart';

/// Класс управления состоянием AuthScreen
class ServiceAuthBloc {
  final _streamController = StreamController<AuthBlocState>();
  Stream<AuthBlocState> get streamController => _streamController.stream;

  /// Регистрация нового пользователя, получение AccessToken
  /// и запись AccessToken в SharedPreferences. Принимает номер теелфона
  /// пользователя String [phone], пароль пользователя String [phone]
  Future<void> loadingRegistration(
    String phone,
    String password,
  ) async {
    _streamController.sink.add(AuthBlocState.loading());
    UserRegistrationProvider().postUserRegistration(phone, password).then(
      (responseJsonRegistration) {
        _streamController.sink
            .add(AuthBlocState.loadedRegistration(responseJsonRegistration));
        UserLogInProvider().setAccessTokenInSharedPreferences(
            accessToken: responseJsonRegistration.accessToken as String);
      },
    ).catchError(
      (exception) {
        if (exception is UserAlreadyRegisteredException) {
          _streamController.sink.add(AuthBlocState.userAlreadyRegistered());
        } else if (exception is AccessTokenNotSetInSharedPreferencesException) {
          _streamController.sink.add(AuthBlocState.accessTokenNotSet());
        } else {
          print('Ошибка выполнения запроса регистрации');
        }
      },
    );
  }

  /// Авторизация пользователя, получение AccessToken
  /// и запись AccessToken в SharedPreferences. Принимает номер телефона
  /// пользователя String [phone], пароль пользователя String [password]
  Future<void> loadingLogIn(
    String phone,
    String password,
  ) async {
    _streamController.sink.add(AuthBlocState.loading());
    UserLogInProvider().postUserLogIn(phone, password).then(
      (responseJsonLogIn) {
        _streamController.sink
            .add(AuthBlocState.loadedLogIn(responseJsonLogIn));
        UserLogInProvider().setAccessTokenInSharedPreferences(
            accessToken: responseJsonLogIn.accessToken as String);
      },
    ).catchError(
      (exception) {
        if (exception is ErrorPasswordException) {
          _streamController.sink.add(AuthBlocState.errorPassword());
        } else if (exception is NotRegisteredException) {
          _streamController.sink.add(AuthBlocState.notRegistered());
        } else if (exception is AccessTokenNotSetInSharedPreferencesException) {
          _streamController.sink.add(AuthBlocState.accessTokenNotSet());
        } else {
          print('Ошибка выполнения запроса авторизации');
        }
      },
    );
  }

  /// Пробрасывает состояние для показа вводимого пароль
  void showPasswordBloc() {
    _streamController.sink.add(AuthBlocState.showPassword());
  }
  /// Пробрасывает состояние для сокрытия вводимого пароль
  void closePasswordBloc() {
    _streamController.sink.add(AuthBlocState.closePassword());
  }

  void dispose() {
    _streamController.close();
  }
}

/// Классы исключений
class UserAlreadyRegisteredException implements Exception {}

class ErrorPasswordException implements Exception {}

class NotRegisteredException implements Exception {}

class AccessTokenNotSetInSharedPreferencesException implements Exception {}
