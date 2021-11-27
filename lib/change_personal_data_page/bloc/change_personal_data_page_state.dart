
class ChangePersonalDataState {
  ChangePersonalDataState();
  factory ChangePersonalDataState.loadUserDataState(Map<String, String?> userDataFromSharedPreferences) = LoadUserDataState;

}


class LoadUserDataState extends ChangePersonalDataState {
  Map<String, String?> userDataFromSharedPreferences;
  LoadUserDataState(this.userDataFromSharedPreferences);
}