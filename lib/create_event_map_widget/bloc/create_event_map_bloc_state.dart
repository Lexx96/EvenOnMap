

import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEventMapState {
  CreateEventMapState();
  factory CreateEventMapState.loadedAddressFromCoordinatesState(LatLng position, List<Placemark> placemark) = LoadedAddressFromCoordinatesState;
  factory CreateEventMapState.loadedAddressFromCoordinatesForCreateEventState(Address addresses, LatLng onTabLatLng) = LoadedAddressFromCoordinatesForCreateEventState;

}

class LoadedAddressFromCoordinatesForCreateEventState extends CreateEventMapState {
  Address addresses;
  LatLng onTabLatLng;
  LoadedAddressFromCoordinatesForCreateEventState(this.addresses, this.onTabLatLng);
}

class LoadedAddressFromCoordinatesState extends CreateEventMapState {
  LatLng position;
  List<Placemark> placemark;
  LoadedAddressFromCoordinatesState(this.position, this.placemark);
}

