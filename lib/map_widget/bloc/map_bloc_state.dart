import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMapState;
  factory MapBlocState.getMapThemeState(String mapStyle) = GetMapThemeState;
  factory MapBlocState.loadedAddressFromCoordinates(Address addressUserPosition, LatLng latLngUserPosition) = LoadedAddressFromUserPositionState;
}

class EmptyGoogleMapState extends MapBlocState {}

class GetMapThemeState extends MapBlocState {
  String mapStyle;
  GetMapThemeState(this.mapStyle);
}

class EmptyOnTabForCreateEventState extends MapBlocState {}

class LoadedAddressFromUserPositionState extends MapBlocState {
  LatLng latLngUserPosition;
  Address addressUserPosition;
  LoadedAddressFromUserPositionState(this.addressUserPosition, this.latLngUserPosition);
}
