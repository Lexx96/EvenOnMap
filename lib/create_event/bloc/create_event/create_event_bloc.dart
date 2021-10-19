import 'dart:async';

import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';

import 'create_event_bloc_state.dart';

class ServiceNewEventBloc {
  final _streamController = StreamController<NewEventBlocState>();

  Stream<NewEventBlocState> get streamEventController =>
      _streamController.stream;

  void emptyEventBloc() {
    _streamController.sink.add(NewEventBlocState.emptyEvent());
  }

  void loadingPostEventBloc(
    String title,
    String description,
    String id,
    double lat,
    double lng,
    String userId,
    String createAt,
    String updateAt,
  ) {
    _streamController.sink.add(NewEventBlocState.loadingEvent());

    PostNewEventProvider()
        .postNewEvent(
            title, description, id, lat, lng, userId, createAt, updateAt)
        .then(
      (responseJsonNewEvent) {
        try {
          if (responseJsonNewEvent.isNotEmpty) {
            _streamController.sink
                .add(NewEventBlocState.loadedEvent(responseJsonNewEvent));
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
