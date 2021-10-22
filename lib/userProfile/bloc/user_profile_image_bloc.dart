
import 'dart:async';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:event_on_map/userProfile/services/user_profile__image_provider.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImageBloc {
  final _streamController = StreamController<UserProfileImageBlocState>();

  Stream<UserProfileImageBlocState> get streamPersonalData => _streamController.stream;

  void emptyUserProfileBloc(){
    _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
  }

  void addPersonalImageBloc(ImageSource source){
    _streamController.sink.add(UserProfileImageBlocState.loadingPickImage());
    try{
      UserProfileProvider().getImageFileUserProfile(source).then((image) {
        _streamController.sink.add(UserProfileImageBlocState.loadedPickImage(image));
      });
    }
    catch(error){
      print('Ошибка получения изображения от провайдета $error');
      _streamController.sink.add(UserProfileImageBlocState.emptyPickImage());
    }
  }

  void dispose(){
    _streamController.close();
  }
}