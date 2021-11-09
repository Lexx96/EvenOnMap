import 'dart:async';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_bloc_state.dart';

class GoogleMapBloc {
  final _streamController = StreamController<MapBlocState>();

  Stream<MapBlocState> get streamMapController => _streamController.stream;

  /// Получение LatLng и адресса местоположения пользователя
  void getLatLngAndAddressUserPosition() async {
    _streamController.sink.add(MapBlocState.emptyLatLng());
    await MapProvider.determinePosition().then(
      (getPositionFromGPS) async {
        List<Placemark> _placemark =
            await MapProvider.getAddressFromLatLongGPS(
                getPositionFromGPS);
        _streamController.sink.add(MapBlocState.loadedLatLngAndAddress(
            getPositionFromGPS, _placemark));
      },
    );
  }

  /// Определение адреса по LatLng [package:geocoder]
  void getAddressOnTab(LatLng onTabLatLng) async {
    await MapProvider.getAddressFromCoordinates(onTabLatLng).then(
      (addressesInOnTab) {
        _streamController.sink.add(MapBlocState.loadedAddressFromCoordinates(addressesInOnTab, onTabLatLng));
      },
    );
  }

  void refreshSet ({required Set<Marker> set, required Marker marker}) {
    Set<Marker> refreshedSet = MapProvider.refreshSetProvider(set: set, marker: marker);

  }

  void dispose() {
    _streamController.close();
  }
}
