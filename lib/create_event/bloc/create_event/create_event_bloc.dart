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

  /// Размещение нового события на сервер и получение данных
  Future<void> loadingPostEventBloc({
    String? title,
    String? description,
    String? lat,
    String? lng,
  }) async {
    _streamController.sink.add(NewEventBlocState.loadingEvent());

    PostNewEventProvider()
        .postNewEvent(
      title: title,
      description: description,
      lat: lat,
      lng: lng,
    )
        .then(
      (responseModelNewEvent) {
        _streamController.sink
            .add(NewEventBlocState.loadedEvent(responseModelNewEvent));
      },
    ).catchError(
      (exception) {
        if (exception is PostEvenErrorSendingServerException) {
          _streamController.sink
              .add(NewEventBlocState.postEvenErrorSendingServer());
        } else if (exception is PostEventNotRegisteredSendingServerException) {
          _streamController.sink
              .add(NewEventBlocState.postEventNotRegisteredSendingServer());
        } else {
          print('Ошибка выполнения запроса регистрации');
          _streamController.sink.add(NewEventBlocState.emptyEvent());
        }
      },
    );
  }

  /// Получение данных о местоположении
  void getLatLngOnMap() {
    _streamController.sink.add(NewEventBlocState.getLatLngLoading());
    PostNewEventProvider.determinePosition().then(
      (getPosition) {
        _streamController.sink
            .add(NewEventBlocState.getLatLngLoaded(getPosition));
      },
    );
  }

  void dispose() {
    _streamController.close();
  }
}

class PostEvenErrorSendingServerException implements Exception {}

class PostEventNotRegisteredSendingServerException implements Exception {}
