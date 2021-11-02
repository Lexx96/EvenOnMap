import 'dart:async';
import 'dart:io';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:event_on_map/userProfile/services/user_profile__image_provider.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImageBloc {
  final _streamController = StreamController<UserProfileImageBlocState>();

  Stream<UserProfileImageBlocState> get streamPersonalData => _streamController.stream;

  final _streamControllerForDrawer = StreamController<UserProfileImageBlocState>();

  Stream<UserProfileImageBlocState> get streamPersonalDataForDrawer => _streamControllerForDrawer.stream;

  void emptyUserProfileImageBloc() {
    _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
  }

  void addPersonalImageBloc(ImageSource source) {
    _streamController.sink.add(UserProfileImageBlocState.loadingPickImage());
    try {
      UserProfileProvider().getImageFileUserProfile(source).then(
        (image) async {
              _streamControllerForDrawer.sink.add(UserProfileImageBlocState.loadedImageUserProfileForDrawer(image));
              _streamController.sink.add(UserProfileImageBlocState.loadedPickImage(image));
              await UserProfileProvider().writePhotoInMemory(image as File);
            },
      );
    } catch (error) {
      print('Ошибка получения изображения от провайдета $error');
      _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
    }
  }



  // void writePhotoInMemoryBloc(File photo) async {
  //   _streamController.sink.add(UserProfileImageBlocState.loadingPickImage());
  //   await UserProfileProvider().writePhotoInMemory(photo).then(
  //         (value) {},
  //       );
  // }

  void disposeImageStream() {
    _streamControllerForDrawer.close();
  }

  void dispose() {
    _streamController.close();
  }
}
