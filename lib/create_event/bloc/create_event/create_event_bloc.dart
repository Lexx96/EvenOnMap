import 'dart:async';
import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  /// Получение адресса местоположения пользователя
  void getLatLngAndAddressUserPosition() async {
    _streamController.sink.add(NewEventBlocState.emptyEvent());
    await MapProvider.determinePosition().then(
          (getPositionFromGPS) async {
            LatLng initialLatLng = LatLng(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        List<Placemark> _placemark =
        await MapProvider.getAddressFromLatLongGPS(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        _streamController.sink.add(NewEventBlocState.getLatLngInitialState(_placemark, initialLatLng));
      },
    );
  }


  /// Определение адреса по LatLng [package:geocoder]
  void getLatLngFromMap(LatLng onTabLatLng) async {
    await MapProvider.getAddressFromCoordinates(onTabLatLng).then(
      (addressesInOnTab) async {
        List<Placemark> _placemark = await MapProvider.getAddressFromLatLongGPS(
            onTabLatLng.latitude, onTabLatLng.longitude);
        print(_placemark);
        _streamController.sink.add(
          NewEventBlocState.getLatLngFromMapState(_placemark, onTabLatLng),
        );
      },
    );
  }

  void dispose() {
    _streamController.close();
  }
}

class PostEvenErrorSendingServerException implements Exception {}

class PostEventNotRegisteredSendingServerException implements Exception {}
