import 'package:event_on_map/news_page/models/news.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMapState;
  factory MapBlocState.getMapThemeState(String mapStyle) = GetMapThemeState;
  // factory MapBlocState.allNewsLoadedState(List<GetNewsFromServerModel> newsFromServer) = AllNewsLoadedState;
  factory MapBlocState.loadedLatLngAndAddressFromOnTab(LatLng onTabLatLng, Address onTabAddress) = LoadedLatLngAndAddressFromOnTabState;
  factory MapBlocState.loadedAddressFromCoordinates(Address addressUserPosition, LatLng latLngUserPosition) = LoadedAddressFromUserPositionState;

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

class LoadedLatLngAndAddressFromOnTabState extends MapBlocState {
  LatLng onTabLatLng;
  Address onTabAddress;
  LoadedLatLngAndAddressFromOnTabState(this.onTabLatLng, this.onTabAddress);
}

class LoadedAddressFromUserPositionState extends MapBlocState {
  LatLng latLngUserPosition;
  Address addressUserPosition;
  LoadedAddressFromUserPositionState(this.addressUserPosition, this.latLngUserPosition);
}
