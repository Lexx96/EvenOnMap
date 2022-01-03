import 'dart:async';
import 'package:event_on_map/modules/userProfile/service/user_profile_service.dart';

import 'change_personal_data_page_state.dart';

class ChangePersonalDataBloc {
  final _streamController = StreamController<ChangePersonalDataState>();

  Stream<ChangePersonalDataState> get streamChangePersonalData =>
      _streamController.stream;

  /// Пустое состояние
  void emptyChangePersonalDataBloc () {
    _streamController.sink.add(ChangePersonalDataState.emptyChangePersonalDataState());
  }

  /// Показать сообщение о недостаточном колличестве символов
  void shoeMessageChangePersonalDataBloc () {
    _streamController.sink.add(ChangePersonalDataState.shoeMessageChangePersonalDataState());
  }

  /// Сохранение данных о пользователе
  void saveUserDataFromServerBloc ({
    required String name,
    required String surName,
    String? aboutMe,
    String? patronimyc,
    String? city,
    String? email,
}) async{
    _streamController.sink.add(ChangePersonalDataState.loadingChangePersonalDataState());
    try{
      await UserProfileProvider()
          .postUserDataOnServerProvider(
        name: name,
        surName: surName,
        patronimyc: patronimyc,
        city: city,
        email: email,
      ).whenComplete(
            () async {
          await UserProfileProvider().saveUserDataInSharedPreferences(aboutMe: aboutMe);
          await UserProfileProvider().getDataFromServerAndSaveInSharedPreferencesProvider();
        },
      );
      _streamController.sink.add(ChangePersonalDataState.loadedChangePersonalDataState());
    }catch(e){
      throw Exception(e);
    }
  }

  /// Получение данных о пользователе из SharedPreferences
  void loadUserDataFromSharedPreferencesBloc () async {
    try{
      Map<String, String?> userDataFromSharedPreferences = await UserProfileProvider().getDataFromSharedPreferencesProvider();
      _streamController.sink.add(ChangePersonalDataState.loadUserDataState(userDataFromSharedPreferences));
    }catch(e){
      throw Exception(e);
    }
  }

  dispose() {
    _streamController.close();
  }
}
