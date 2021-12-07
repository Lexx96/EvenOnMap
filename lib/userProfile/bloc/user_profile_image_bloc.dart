import 'dart:async';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:event_on_map/userProfile/services/user_profile_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
          if (image != null) {
            await UserProfileProvider().writePhotoInMemory(image);
            readUserProfileImageBloc();
            await UserProfileProvider.postUserImageProvider(image: image);
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

  /// Получение данных о пользователе из SharedPreferencesBloc
  void getUserDataFromSharedPreferencesBloc() async {
    try {
      await UserProfileProvider()
          .getDataFromServerAndSaveInSharedPreferencesProvider(); // долго грузит страницу
      final userDataFromSharedPreferences =
          await UserProfileProvider().getDataFromSharedPreferencesProvider();
      _streamController.sink.add(
          UserProfileImageBlocState.getUserDataInSharedPreferencesState(
              userDataFromSharedPreferences));
    } catch (e) {
      throw Exception(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
