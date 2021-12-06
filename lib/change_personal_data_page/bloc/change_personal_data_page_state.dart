
class ChangePersonalDataState {
  ChangePersonalDataState();
  factory ChangePersonalDataState.emptyChangePersonalDataState() = EmptyChangePersonalDataState;
  factory ChangePersonalDataState.shoeMessageChangePersonalDataState() = ShoeMessageChangePersonalDataState;
  factory ChangePersonalDataState.loadUserDataState(Map<String, String?> userDataFromSharedPreferences) = LoadUserDataState;

}

class EmptyChangePersonalDataState extends ChangePersonalDataState {}

class ShoeMessageChangePersonalDataState extends ChangePersonalDataState {}

class LoadUserDataState extends ChangePersonalDataState {
  Map<String, String?> userDataFromSharedPreferences;
  LoadUserDataState(this.userDataFromSharedPreferences);
}