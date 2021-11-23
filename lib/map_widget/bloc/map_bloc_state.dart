import 'package:event_on_map/news_page/models/news.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMapState;
  factory MapBlocState.loadedAddressFromUserPositionState(Set<Marker> setUserMarker) = LoadedAddressFromUserPositionState;
  factory MapBlocState.getAllNewsFromServerState({required Set<Marker> markers,  required List<GetNewsFromServerModel> listAllNews}) = GetAllNewsFromServerState;
}

class EmptyGoogleMapState extends MapBlocState {}

class EmptyOnTabForCreateEventState extends MapBlocState {}

class LoadedAddressFromUserPositionState extends MapBlocState {
  Set<Marker> setUserMarker;
  LoadedAddressFromUserPositionState(this.setUserMarker);
}

class GetAllNewsFromServerState extends MapBlocState{
  Set<Marker> markers;
  List<GetNewsFromServerModel> listAllNews;
  GetAllNewsFromServerState({required this.markers, required this.listAllNews} );
}
