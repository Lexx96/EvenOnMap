

import 'dart:async';

import 'package:event_on_map/create_event/bloc/pick_image/pick_image_bloc_state.dart';
import 'package:event_on_map/create_event/services/pick_image/pick_image_provider.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBloc {
  final _streamController = StreamController<PickImageBlocState>();

  Stream<PickImageBlocState> get streamPickImage => _streamController.stream;

  void emptyPickImageBloc(){
    _streamController.sink.add(PickImageBlocState.emptyPickImage());
  }

  void addPickImageBloc(ImageSource source){
    _streamController.sink.add(PickImageBlocState.loadingPickImage());
    try{
      PickImageProvider().getImageFile(source).then((image) {
        _streamController.sink.add(PickImageBlocState.loadedPickImage(image));
      });
    }
    catch(error){
      print('Ошибка получения изображения от провайдета $error');
      _streamController.sink.add(PickImageBlocState.emptyPickImage());
    }
  }

  void dispose(){
    _streamController.close();
  }
}