import 'dart:async';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_provider.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_api_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_provider.dart';
import 'auth_bloc_state.dart';

class ServiceAuthBloc {
  final UserRegistrationRepository _authRegistrationRepository;
  final UserLogInRepository _authLogInRepository;

  ServiceAuthBloc(
    this._authRegistrationRepository,
    this._authLogInRepository,
  );

  final _streamController = StreamController<AuthBlocState>();

  Stream<AuthBlocState> get streamController => _streamController.stream;

  void emptyState() {
    _streamController.sink.add(AuthBlocState.emptyBlocState());
  }

  /// Регистрация и получения данных
  void loadingRegistration(
    String phone,
    String password,
  ) {
    _streamController.sink.add(AuthBlocState.loadingRegistration());
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
          _streamController.sink.add(AuthBlocState.emptyBlocState());
        }
      },
    );
  }

  /// Авторизация и получения данных
  void loadingLogIn(
    String phone,
    String password,
  ) {
    _streamController.sink.add(AuthBlocState.loadingLogIn());
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
          _streamController.sink.add(AuthBlocState.emptyBlocState());
        }
      },
    );
  }

  void errorLengthNumber() {
    _streamController.sink.add(AuthBlocState.errorLengthNumber());
  }

  void errorLengthPassword() {
    _streamController.sink.add(AuthBlocState.errorLengthPassword());
  }

  void errorLengthLoginAndPassword() {
    _streamController.sink.add(AuthBlocState.errorLengthLoginAndPassword());
  }

  void showPasswordBloc () {
    _streamController.sink.add(AuthBlocState.showPassword());
  }

  void closePasswordBloc () {
    _streamController.sink.add(AuthBlocState.closePassword());
  }

  void dispose() {
    _streamController.close();
  }
}

class UserAlreadyRegisteredException implements Exception {
  String getErrorMessage() {
    return 'Пользователь уже зарегистрирован';
  }
}

class ErrorPasswordException implements Exception {}

class NotRegisteredException implements Exception {}

class AccessTokenNotSetInSharedPreferencesException implements Exception {}
