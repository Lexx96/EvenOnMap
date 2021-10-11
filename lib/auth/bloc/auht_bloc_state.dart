class AuthBlocState{
  AuthBlocState();

  factory AuthBlocState.empty() = AuthEmptyState;
  factory AuthBlocState.loadingRegistration() = AuthRegistrationLoadingState;
  factory AuthBlocState.loadedRegistration() = AuthRegistrationLoadedState;
  factory AuthBlocState.loadingLogIn() = AuthLogInLoadingState;
  factory AuthBlocState.loadedLogIn() = AuthLogInLoadedState;

}


class AuthEmptyState extends AuthBlocState{}

class AuthRegistrationLoadingState extends AuthBlocState {}

class AuthRegistrationLoadedState extends AuthBlocState {}

class AuthLogInLoadingState extends AuthBlocState {}

class AuthLogInLoadedState extends AuthBlocState {}

