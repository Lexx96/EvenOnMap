import 'package:event_on_map/news_page/models/news.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMapState;
  factory MapBlocState.getMapThemeState(String mapStyle) = GetMapThemeState;
  // factory MapBlocState.allNewsLoadedState(List<GetNewsFromServerModel> newsFromServer) = AllNewsLoadedState;
  factory MapBlocState.loadedLatLngAndAddress( LatLng position, List<Placemark> placemark) = LoadedLatLngAndAddressState;
  factory MapBlocState.loadedAddressFromCoordinates(Address addresses, LatLng onTabLatLng) = LoadedAddressFromCoordinatesState;

}

class EmptyGoogleMapState extends MapBlocState {}

class GetMapThemeState extends MapBlocState {
  String mapStyle;
  GetMapThemeState(this.mapStyle);
}

// class AllNewsLoadedState extends MapBlocState {
//   List<GetNewsFromServerModel> newsFromServer;
//   AllNewsLoadedState(this.newsFromServer);
// }

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
