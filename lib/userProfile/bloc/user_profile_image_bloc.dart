import 'dart:async';
import 'dart:io';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:event_on_map/userProfile/services/user_profile__image_provider.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImageBloc {
  final _streamController = StreamController<UserProfileImageBlocState>();

  Stream<UserProfileImageBlocState> get streamPersonalData =>
      _streamController.stream;

  /// Получение и установка изображения на аватарку
  void addPersonalImageBloc(ImageSource source) {
    _streamController.sink.add(UserProfileImageBlocState.loadingPickImage());
    try {
      UserProfileProvider().getImageFileUserProfile(source).then(
        (image) async {
          await UserProfileProvider().writePhotoInMemory(image as File);
          readUserProfileImageBloc();
        },
      );
    } catch (error) {
      print('Ошибка получения изображения от провайдета $error');
      _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
    }
  }

  /// Чтение изображения для аватарки из памяти
  void readUserProfileImageBloc() async {
    _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());

    await UserProfileProvider().readPhotoFromMemory().then(
      (imageFromMemory) {
        _streamController.sink
            .add(UserProfileImageBlocState.loadedPickImage(imageFromMemory));
      },
    ).catchError((e){
        _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
      },
    );
  }

  /// Удаление аватарки
  void deleteUserProfileImageBloc() async {
    _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());

    await UserProfileProvider().deletePhotoFromMemory().catchError(
          (e) {
        _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
      },
    );
  }

  /// Получение данных о пользователе
  void getUserDataFromSharedPreferencesBloc () async {
    try{
      final userDataFromSharedPreferences = await UserProfileProvider().getDataFromSharedPreferences();
      _streamController.sink.add(UserProfileImageBlocState.getUserDataInSharedPreferencesState(userDataFromSharedPreferences));
    }catch(e){
      throw Exception(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
