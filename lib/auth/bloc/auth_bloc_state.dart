import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/models/registration/user_registration.dart';

class AuthBlocState{
  AuthBlocState();
  factory AuthBlocState.emptyBlocState() = EmptyBlocState;
  factory AuthBlocState.loadingRegistration() = AuthRegistrationLoadingState;
  factory AuthBlocState.loadedRegistration(UserRegistrationModel userRegistrationModel) = AuthRegistrationLoadedState;
  factory AuthBlocState.loadingLogIn() = AuthLogInLoadingState;
  factory AuthBlocState.loadedLogIn(UserLogInModel userLogInModel) = AuthLogInLoadedState;
  factory AuthBlocState.errorLengthNumber() = ErrorLengthNumber;
  factory AuthBlocState.errorLengthPassword() = ErrorLengthPassword;
  factory AuthBlocState.errorLengthLoginAndPassword() = ErrorLengthLoginAndPassword;
  factory AuthBlocState.userAlreadyRegistered() = UserAlreadyRegistered;
  factory AuthBlocState.errorPassword() = ErrorPassword;
  factory AuthBlocState.notRegistered() = NotRegistered;
}

class EmptyBlocState extends AuthBlocState{}

class AuthRegistrationLoadingState extends AuthBlocState {}

class AuthRegistrationLoadedState extends AuthBlocState {
  UserRegistrationModel userRegistrationModel;
  AuthRegistrationLoadedState(this.userRegistrationModel);
}

class AuthLogInLoadingState extends AuthBlocState {}

class AuthLogInLoadedState extends AuthBlocState {
  UserLogInModel userLogInModel;
  AuthLogInLoadedState(this.userLogInModel);
}

class ErrorLengthNumber extends AuthBlocState {}

class ErrorLengthPassword extends AuthBlocState {}

class ErrorLengthLoginAndPassword extends AuthBlocState {}

class UserAlreadyRegistered extends AuthBlocState {}

class ErrorPassword extends AuthBlocState {}

class NotRegistered extends AuthBlocState {}



