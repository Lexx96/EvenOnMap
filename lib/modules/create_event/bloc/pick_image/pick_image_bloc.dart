import 'dart:async';
import 'package:event_on_map/modules/create_event/bloc/pick_image/pick_image_bloc_state.dart';
import 'package:event_on_map/modules/create_event/services/pick_image/pick_image_servise.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBloc {
  final _streamController = StreamController<PickImageBlocState>();

  Stream<PickImageBlocState> get streamPickImage => _streamController.stream;

  void notSelectedPickImage() {
    _streamController.sink.add(PickImageBlocState.notSelectedPickImage());
  }

  void addPickImageBloc(ImageSource source) {
    _streamController.sink.add(PickImageBlocState.loadingPickImage());
    try {
      PickImageProvider().getImageFile(source).then(
        (image) {
          if (image != null) {
            _streamController.sink
                .add(PickImageBlocState.loadedPickImage(image));
          } else {
            _streamController.sink
                .add(PickImageBlocState.notSelectedPickImage());
          }
        },
      );
    } catch (error) {
      print('Ошибка получения изображения от провайдета $error');
      _streamController.sink.add(PickImageBlocState.notSelectedPickImage());
    }
  }

  void dispose() {
    _streamController.close();
  }
}
