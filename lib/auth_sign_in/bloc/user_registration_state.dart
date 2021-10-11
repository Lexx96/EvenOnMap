

import 'package:event_on_map/auth_sign_in/models/user_data.dart';

class SignInBlocState {
  SignInBlocState();
  factory SignInBlocState.empty() = ClearBlocEmpty;
  factory SignInBlocState.loading() = ClearBlocLoading;
  factory SignInBlocState.loaded() = ClearBlocLoaded;
  factory SignInBlocState.error() = ClearBlocError;
  factory SignInBlocState.response(List<UserData> responseJson) = ClearBlocResponse;
}



class ClearBlocEmpty extends SignInBlocState{}

class ClearBlocLoading extends SignInBlocState{}

class ClearBlocLoaded extends SignInBlocState{}

class ClearBlocError extends SignInBlocState{}

class ClearBlocResponse extends SignInBlocState{
  final List<UserData> responseJson;
  ClearBlocResponse(this.responseJson);
}