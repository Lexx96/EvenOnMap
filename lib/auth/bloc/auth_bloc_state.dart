import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/models/registration/user_registration.dart';

class AuthBlocState{
  AuthBlocState();

  factory AuthBlocState.emptyLogIn() = AuthEmptyState;
  factory AuthBlocState.emptyRegistration() = AuthRegistrationEmptyState;
  factory AuthBlocState.loadingRegistration() = AuthRegistrationLoadingState;
  factory AuthBlocState.loadedRegistration(List<UserRegistrationModel> userRegistrationModel) = AuthRegistrationLoadedState;
  factory AuthBlocState.loadingLogIn() = AuthLogInLoadingState;
  factory AuthBlocState.loadedLogIn(List<UserLogInModel> userLogInModel) = AuthLogInLoadedState;

}


class AuthEmptyState extends AuthBlocState{}

class AuthRegistrationEmptyState extends AuthBlocState{}

class AuthRegistrationLoadingState extends AuthBlocState {}

class AuthRegistrationLoadedState extends AuthBlocState {
  List<UserRegistrationModel> userRegistrationModel;
  AuthRegistrationLoadedState(this.userRegistrationModel);
}

class AuthLogInLoadingState extends AuthBlocState {}

class AuthLogInLoadedState extends AuthBlocState {
  List<UserLogInModel> userLogInModel;
  AuthLogInLoadedState(this.userLogInModel);
}

