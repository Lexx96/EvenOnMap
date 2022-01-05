import 'package:event_on_map/modules/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/modules/auth/models/registration/user_registration.dart';

/// Состояния модуля auth
class AuthBlocState{
  AuthBlocState();
  factory AuthBlocState.loading() = LoadingState;
  factory AuthBlocState.loadedRegistration(UserRegistrationModel userRegistrationModel) = RegistrationLoadedState;
  factory AuthBlocState.loadedLogIn(UserLogInModel userLogInModel) = LogInLoadedState;
  factory AuthBlocState.userAlreadyRegistered() = UserAlreadyRegistered;
  factory AuthBlocState.errorPassword() = ErrorPassword;
  factory AuthBlocState.notRegistered() = NotRegistered;
  factory AuthBlocState.accessTokenNotSet() = AccessTokenNotSet;
  factory AuthBlocState.showPassword() = ShowPassword;
  factory AuthBlocState.closePassword() = ClosePassword;
}

/// Состояние загрузки
class LoadingState extends AuthBlocState {}

/// Состояние окончания регистрации нового пользователя, принимает экземпляр
/// модели UserRegistrationModel [userRegistrationModel]
class RegistrationLoadedState extends AuthBlocState {
  UserRegistrationModel userRegistrationModel;
  RegistrationLoadedState(this.userRegistrationModel);
}

/// Состояние окончания авторизации пользователя, принимает экземпляр
/// модели UserLogInModel [userLogInModel]
class LogInLoadedState extends AuthBlocState {
  UserLogInModel userLogInModel;
  LogInLoadedState(this.userLogInModel);
}

/// Состояние при попытке регистрации ранее зарегистрированного пользователя
class UserAlreadyRegistered extends AuthBlocState {}

/// Состояние при неверном пароль при авторизации ранее зарегистрированного пользователя
class ErrorPassword extends AuthBlocState {}

/// Состояние при авторизации ранее не зарегистрированного пользователя
class NotRegistered extends AuthBlocState {}

/// Состояние при ошибке записи  AccessToken в SharedPreferences
class AccessTokenNotSet extends AuthBlocState {}

/// Состояние для показа вводимого пароль
class ShowPassword extends AuthBlocState {}

/// Состояние для сокрытия вводимого пароль
class ClosePassword extends AuthBlocState {}



