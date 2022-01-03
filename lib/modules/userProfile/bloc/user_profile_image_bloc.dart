import 'dart:async';
import 'package:event_on_map/modules/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:event_on_map/modules/userProfile/service/user_profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImageBloc {

  final _streamController = StreamController<UserProfileImageBlocState>();

  Stream<UserProfileImageBlocState> get streamPersonalData =>
      _streamController.stream;

  Stream<UserProfileImageBlocState> get streamUserEvents =>
      _streamController.stream;

  /// Получение новостей размещенных ползователем
  void getUserEvents () {

  }

  /// Получение и установка изображения на аватарку
  Future<void> addPersonalImageBloc(ImageSource source) async{
    _streamController.sink.add(UserProfileImageBlocState.loadingPickImage());
    try {
      UserProfileProvider().getImageFileUserProfile(source).then(
        (image) async {
          if (image != null) {
            await UserProfileProvider.postUserImageProvider(image: image);
            await UserProfileProvider().writePhotoInMemory(image);
            PaintingBinding.instance!.imageCache!.clear();  // Очистка кеша
            await UserProfileProvider().readPhotoFromMemory().then(
                  (imageFromMemory) {
                _streamController.sink
                    .add(UserProfileImageBlocState.loadedPickImage(imageFromMemory));
              },
            );
          } else {
            _streamController.sink
                .add(UserProfileImageBlocState.emptyPickImage());
          }
        },
      );
    } catch (e) {
      print('Ошибка получения изображения от провайдета $e');
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
    ).catchError(
      (e) {
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

  /// Получение данных о пользователе c сервера и из SharedPreferencesBloc
  void getUserDataFromServerAndSharedPreferencesBloc() async {
    try {
      final _userPhoto = await UserProfileProvider().getDataFromServerAndSaveInSharedPreferencesProvider();
      final userDataFromSharedPreferences = await UserProfileProvider().getDataFromSharedPreferencesProvider();
      _streamController.sink.add(UserProfileImageBlocState.getUserDataFromServerAndSharedPreferencesBloc(userDataFromSharedPreferences, _userPhoto));
    } catch (e) {
      throw Exception(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
