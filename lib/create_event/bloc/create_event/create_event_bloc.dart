import 'dart:async';
import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'create_event_bloc_state.dart';

class CreateEventBloc {

  final _streamController = StreamController<NewEventBlocState>();

  Stream<NewEventBlocState> get streamEventController =>
      _streamController.stream;


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
        }
      },
    );
  }

  /// Получение адресса местоположения пользователя
  void getLatLngAndAddressUserPosition() async {
    await MapProvider.determinePosition().then(
          (getPositionFromGPS) async {
            LatLng _initialLatLng = LatLng(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        List<Placemark> _placemark =
        await MapProvider.getAddressFromLatLongGPS(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        _streamController.sink.add(NewEventBlocState.getLatLngAndAddressState(placemark: _placemark, initialLatLng: _initialLatLng),
        );
      },
    );
  }

  /// Определение адреса по LatLng [package:geocoder]
  void getLatLngAndAddressFromMap(LatLng _onTabLatLng) async {
    try{
      List<Placemark> _placemark = await MapProvider.getAddressFromLatLongGPS(
          _onTabLatLng.latitude, _onTabLatLng.longitude);
      _streamController.sink.add(
        NewEventBlocState.getLatLngAndAddressState(placemark: _placemark, initialLatLng: _onTabLatLng),
      );
    }catch(e){
      print(e);
    }
  }

  void openGoogleMapState () {
    _streamController.add(NewEventBlocState.openGoogleMapState());
  }

  void dispose() {
    _streamController.close();
  }
}

class PostEvenErrorSendingServerException implements Exception {}

class PostEventNotRegisteredSendingServerException implements Exception {}
