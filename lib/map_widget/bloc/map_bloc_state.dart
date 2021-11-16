import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMapState;
  factory MapBlocState.getMapThemeState(String mapStyle) = GetMapThemeState;
  factory MapBlocState.loadedLatLngAndAddress( LatLng position, List<Placemark> placemark) = LoadedLatLngAndAddressState;
  factory MapBlocState.loadedAddressFromCoordinates(Address addresses, LatLng onTabLatLng) = LoadedAddressFromCoordinatesState;

}

class EmptyGoogleMapState extends MapBlocState {}

class GetMapThemeState extends MapBlocState {
  String mapStyle;
  GetMapThemeState(this.mapStyle);
}

class EmptyOnTabForCreateEventState extends MapBlocState {}

class LoadedLatLngAndAddressState extends MapBlocState {
  LatLng position;
  List<Placemark> placemark;
  LoadedLatLngAndAddressState(this.position, this.placemark);
}

class LoadedAddressFromCoordinatesState extends MapBlocState {
  LatLng onTabLatLng;
  Address addresses;
  LoadedAddressFromCoordinatesState(this.addresses, this.onTabLatLng);
}
