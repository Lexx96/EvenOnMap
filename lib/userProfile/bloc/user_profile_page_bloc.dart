

import 'dart:async';
import 'package:event_on_map/userProfile/bloc/user_profile_page_bloc_state.dart';
import 'package:event_on_map/userProfile/services/user_profile__page_provider.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileBloc {
  final _streamController = StreamController<UserProfileBlocState>();

  Stream<UserProfileBlocState> get streamPersonalData => _streamController.stream;

  void emptyUserProfileBloc(){
    _streamController.sink.add(UserProfileBlocState.emptyPickImage());
  }

  void addPersonalImageBloc(ImageSource source){
    _streamController.sink.add(UserProfileBlocState.loadingPickImage());
    try{
      UserProfileProvider().getImageFileUserProfile(source).then((image) {
        _streamController.sink.add(UserProfileBlocState.loadedPickImage(image));
      });
    }
    catch(error){
      print('Ошибка получения изображения от провайдета $error');
      _streamController.sink.add(UserProfileBlocState.emptyPickImage());
    }
  }

  void dispose(){
    _streamController.close();
  }
}