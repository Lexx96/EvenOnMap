
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEventMapState {
  CreateEventMapState();
  factory CreateEventMapState.readMyLastPositionForCreateEventState(LatLng? myLastPosition) = ReadMyLastPositionForCreateEventState;
  factory CreateEventMapState.loadedAddressFromCoordinatesState(LatLng position, List<Placemark> placemark) = LoadedAddressFromCoordinatesState;
}

class LoadedAddressFromCoordinatesState extends CreateEventMapState {
  LatLng position;
  List<Placemark> placemark;
  LoadedAddressFromCoordinatesState(this.position, this.placemark);
}

class ReadMyLastPositionForCreateEventState extends CreateEventMapState {
  LatLng? myLastPosition;
  ReadMyLastPositionForCreateEventState(this.myLastPosition);
}