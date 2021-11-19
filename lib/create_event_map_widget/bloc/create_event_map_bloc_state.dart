

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEventMapState {
  CreateEventMapState();
  factory CreateEventMapState.loadedAddressFromCoordinatesState(LatLng position, List<Placemark> placemark) = LoadedAddressFromCoordinatesState;
  factory CreateEventMapState.getMapThemeForCreateEventMapState(String mapStyle) = GetMapThemeForCreateEventMapState;
}

class GetMapThemeForCreateEventMapState extends CreateEventMapState {
  String mapStyle;
  GetMapThemeForCreateEventMapState(this.mapStyle);
}

class LoadedAddressFromCoordinatesState extends CreateEventMapState {
  LatLng position;
  List<Placemark> placemark;
  LoadedAddressFromCoordinatesState(this.position, this.placemark);
}

