
import 'dart:async';
import 'dart:io';
import 'package:event_on_map/userProfile/services/user_profile__image_provider.dart';

import 'main_drawer_state.dart';

class MainDrawerBloc {

  final _streamController = StreamController<MainDrawerBlocState>();

  Stream<MainDrawerBlocState> get streamController => _streamController.stream;

  void emptyMainDrawerState () async {
    _streamController.sink.add(MainDrawerBlocState.emptyMainDrawerState());

    await UserProfileProvider().readPhotoFromMemory().then(
          (imageFromMemory) {
            _streamController.sink.add(MainDrawerBlocState.loadedImageUserProfileForDrawer(imageFromMemory));
      },
    ).catchError((e){
      _streamController.sink.add(MainDrawerBlocState.emptyMainDrawerState());
    });
  }

   void loadedImageUserProfileForDrawer ([File? image]){
    _streamController.sink.add(MainDrawerBlocState.loadedImageUserProfileForDrawer(image));
  }

  void dispose () {
    _streamController.close();
  }
}