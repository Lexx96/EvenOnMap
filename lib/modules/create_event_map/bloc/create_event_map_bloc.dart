import 'dart:async';
import 'package:event_on_map/modules/map_widget/service/map_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'create_event_map_bloc_state.dart';

class CreateEventMapBloc {

  final _streamCreateEventController = StreamController<CreateEventMapState>();
  Stream<CreateEventMapState> get streamCreateEventMapController => _streamCreateEventController.stream;

  /// Получение LatLng и адресса местоположения пользователя при инициализации экрана выбора адреса события
  void createEventGetLatLngAndAddressUserPosition() async {
    await MapProvider.determinePosition().then(
          (getPositionFromGPS) async {
        List<Placemark> _placemark = await MapProvider.getAddressFromLatLongGPS(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        LatLng position = LatLng(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        _streamCreateEventController.sink.add(CreateEventMapState.loadedAddressFromCoordinatesState(
            position, _placemark));
      },
    );
  }

  /// Определение адреса по LatLng [package:geocoder]
  void getAddressOnTab(LatLng onTabLatLng) async {
    await MapProvider.getAddressFromCoordinates(onTabLatLng).then(
          (addressesInOnTab) async {
        List<Placemark> _placemark =
        await MapProvider.getAddressFromLatLongGPS(onTabLatLng.latitude, onTabLatLng.longitude);
        _streamCreateEventController.sink.add(CreateEventMapState.loadedAddressFromCoordinatesState(
            onTabLatLng, _placemark));
      },
    );
  }

  /// Чтение последнего местоположения пользователя
  void readMyLastPositionForCreateEventBloc () async{
    try{
      final LatLng? myLastPosition = await MapProvider.readMyLastPosition();
      _streamCreateEventController.sink.add(CreateEventMapState.readMyLastPositionForCreateEventState(myLastPosition));
    }catch(e){
      throw Exception(e);
    }
  }

  void dispose () {
    _streamCreateEventController.close();
  }
}