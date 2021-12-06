import 'dart:async';

import 'package:event_on_map/userProfile/services/user_profile_provider.dart';

import 'change_personal_data_page_state.dart';

class ChangePersonalDataBloc {
  final _streamController = StreamController<ChangePersonalDataState>();

  Stream<ChangePersonalDataState> get streamChangePersonalData =>
      _streamController.stream;

  /// Получение данных о пользователе из SharedPreferences
  void loadUserDataBloc () async {
    try{
      Map<String, String?> userDataFromSharedPreferences = await UserProfileProvider().getDataFromSharedPreferences();
      _streamController.sink.add(ChangePersonalDataState.loadUserDataState(userDataFromSharedPreferences));
    }catch(e){
      throw Exception(e);
    }
  }

  void emptyChangePersonalDataBloc () {
    _streamController.sink.add(ChangePersonalDataState.emptyChangePersonalDataState());
  }

  void shoeMessageChangePersonalDataBloc () {
    _streamController.sink.add(ChangePersonalDataState.shoeMessageChangePersonalDataState());
  }



  dispose() {
    _streamController.close();
  }
}
