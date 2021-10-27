import 'dart:async';

import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';

import 'create_event_bloc_state.dart';

class ServiceNewEventBloc {
  final _streamController = StreamController<NewEventBlocState>();

  Stream<NewEventBlocState> get streamEventController =>
      _streamController.stream;

  void emptyEventBloc() {
    _streamController.sink.add(NewEventBlocState.emptyEvent());
  }

  Future<void> loadingPostEventBloc (
  {
    String? title,
    String? description,
    String? lat,
    String? lng,
  }
  ) async{
    _streamController.sink.add(NewEventBlocState.loadingEvent());

    PostNewEventProvider().postNewEvent(title: title, description: description, lat: lat, lng: lng,)
        .then(
      (responseModelNewEvent) {
        try {
          if (responseModelNewEvent.userId != null) {
            _streamController.sink
                .add(NewEventBlocState.loadedEvent(responseModelNewEvent));
          } else {
            _streamController.sink.add(NewEventBlocState.emptyEvent());
          }
        } catch (error) {
          print('Ошибка запроса на размещение события $error');
          _streamController.sink.add(NewEventBlocState.emptyEvent());
        }
      },
    );
  }

  void getLatLngOnMap(){
    _streamController.sink.add(NewEventBlocState.getLatLng());
  }

  void dispose() {
    _streamController.close();
  }
}
