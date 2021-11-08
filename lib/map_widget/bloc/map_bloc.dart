import 'dart:async';

import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_bloc_state.dart';

class GoogleMapBloc {
  final _streamController = StreamController<MapBlocState>();

  Stream<MapBlocState> get streamMapController => _streamController.stream;

  /// Получение LatLng и адресса местоположения пользователя
  void getLatLngAndAddressUserPosition() async {
    _streamController.sink.add(MapBlocState.loadingLatLng());
    await PostNewEventProvider.determinePosition().then(
      (getPositionFromGPS) async {
        List<Placemark> _placemark =
            await PostNewEventProvider.getAddressFromLatLongGPS(
                getPositionFromGPS);
        _streamController.sink.add(MapBlocState.loadedLatLngAndAddress(
            getPositionFromGPS, _placemark));
      },
    );
  }

  /// Определение адреса по LatLng [package:geolocator]
  void getAddressOnTab(LatLng onTabLatLng) async {
    await PostNewEventProvider.getAddressFromCoordinates(onTabLatLng).then(
      (addressesInOnTab) {
        _streamController.sink.add(MapBlocState.loadedAddressFromCoordinates(addressesInOnTab, onTabLatLng));
      },
    );
  }

  void refreshSet ({required Set<Marker> set, required Marker marker}) {
    Set<Marker> refreshedSet = PostNewEventProvider.refreshSetProvider(set: set, marker: marker);

  }

  void dispose() {
    _streamController.close();
  }
}
