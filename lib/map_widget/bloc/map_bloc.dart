import 'dart:async';

import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'map_bloc_state.dart';

class GoogleMapBloc {
  final _streamController = StreamController<MapBlocState>();

  Stream<MapBlocState> get streamMapController => _streamController.stream;

  /// Получение LatLng и адресса
  void getLatLngAndAddressOnMap() async {
    _streamController.sink.add(MapBlocState.loadingLatLng());
    await PostNewEventProvider.determinePosition().then(
      (getPositionFromGPS) async {
        List<Placemark> _placemark = await PostNewEventProvider.getAddressFromLatLongGPS(getPositionFromGPS);
        _streamController.sink
            .add(MapBlocState.loadedLatLngAndAddress(getPositionFromGPS, _placemark));
      },
    );
  }

  void dispose() {
    _streamController.close();
  }
}
