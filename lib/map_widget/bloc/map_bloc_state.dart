
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMap;
  factory MapBlocState.loadedLatLngAndAddress( Position position, List<Placemark> placemark) = LoadedLatLngAndAddress;
  factory MapBlocState.loadedAddressFromCoordinates(Address addresses, LatLng onTabLatLng) = LoadedAddressFromCoordinates;
}



class EmptyGoogleMap extends MapBlocState {}

class LoadedLatLngAndAddress extends MapBlocState {
  Position position;
  List<Placemark> placemark;
  LoadedLatLngAndAddress(this.position, this.placemark);
}

class LoadedAddressFromCoordinates extends MapBlocState {
  LatLng onTabLatLng;
  Address addresses;
  LoadedAddressFromCoordinates(this.addresses, this.onTabLatLng);
}
