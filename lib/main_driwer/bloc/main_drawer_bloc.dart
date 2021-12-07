import 'dart:async';
import 'dart:io';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:event_on_map/userProfile/services/user_profile_provider.dart';

import 'main_drawer_state.dart';

class MainDrawerBloc {
  final _streamController = StreamController<MainDrawerBlocState>();

  Stream<MainDrawerBlocState> get streamController => _streamController.stream;

  /// Чтение изображения для аватарки из памяти
  void readImageUserBloc() async {
    _streamController.sink.add(MainDrawerBlocState.emptyMainDrawerState());

    await UserProfileProvider().readPhotoFromMemory().then(
      (imageFromMemory) {
        if(imageFromMemory != null) {
          _streamController.sink.add(MainDrawerBlocState.loadedImageUserProfileForDrawerState(imageFromMemory));
        }else {
          _streamController.sink.add(MainDrawerBlocState.emptyMainDrawerState());
        }
      },
    ).catchError(
      (e) {
        _streamController.sink.add(MainDrawerBlocState.emptyMainDrawerState());
      },
    );
  }

  /// Получение имени и фамилии(логина) пользователя
  void getUserDataFromSharedPreferencesMainDrawerBloc () async {
    try{
      final userDataFromSharedPreferences = await UserProfileProvider().getDataFromSharedPreferencesProvider();
      _streamController.sink.add(MainDrawerBlocState.getUserDataFromSharedPreferencesMainDrawerState(userDataFromSharedPreferences));
    }catch(e){
      throw Exception(e);
    }
  }

  /// Закрыть AlertDialog
  void closeAlertDialog() {
    _streamController.sink.add(MainDrawerBlocState.closeAlertDialogState());
  }

  /// Подтверждение выходя из акаунта
  void showMessage() {
    _streamController.sink.add(MainDrawerBlocState.showMessageState());
  }

  void dispose() {
    _streamController.close();
  }
}
