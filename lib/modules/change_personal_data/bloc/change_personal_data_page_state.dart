
class ChangePersonalDataState {
  ChangePersonalDataState();
  factory ChangePersonalDataState.emptyChangePersonalDataState() = EmptyChangePersonalDataState;
  factory ChangePersonalDataState.loadingChangePersonalDataState() = LoadingChangePersonalDataState;
  factory ChangePersonalDataState.loadedChangePersonalDataState() = LoadedChangePersonalDataState;
  factory ChangePersonalDataState.shoeMessageChangePersonalDataState() = ShoeMessageChangePersonalDataState;
  factory ChangePersonalDataState.loadUserDataState(Map<String, String?> userDataFromSharedPreferences) = LoadUserDataState;

}

class EmptyChangePersonalDataState extends ChangePersonalDataState {}

class LoadingChangePersonalDataState extends ChangePersonalDataState {}

class LoadedChangePersonalDataState extends ChangePersonalDataState {}

class ShoeMessageChangePersonalDataState extends ChangePersonalDataState {}

class LoadUserDataState extends ChangePersonalDataState {
  Map<String, String?> userDataFromSharedPreferences;
  LoadUserDataState(this.userDataFromSharedPreferences);
}