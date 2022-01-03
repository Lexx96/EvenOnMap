import 'package:event_on_map/modules/news_page/models/news.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.emptyLatLng() = EmptyGoogleMapState;
  factory MapBlocState.cardForMarkerState(GetNewsFromServerModel dataForCard, String? address) = CardForMarkerState;
  factory MapBlocState.readMyLastPositionState(LatLng? myLastPosition) = ReadMyLastPositionState;
  factory MapBlocState.loadedAddressFromUserPositionState(Set<Marker> setUserMarker) = LoadedAddressFromUserPositionState;
  factory MapBlocState.getAllNewsFromServerState({required Set<Marker> markers,  required List<GetNewsFromServerModel> listAllNews}) = GetAllNewsFromServerState;
}


class EmptyGoogleMapState extends MapBlocState {}

class CardForMarkerState extends MapBlocState {
  GetNewsFromServerModel dataForCard;
  String? address;
  CardForMarkerState(this.dataForCard, this.address);
}

class ReadMyLastPositionState extends MapBlocState {
  LatLng? myLastPosition;
  ReadMyLastPositionState(this.myLastPosition);
}

class LoadedAddressFromUserPositionState extends MapBlocState {
  Set<Marker> setUserMarker;
  LoadedAddressFromUserPositionState(this.setUserMarker);
}

class GetAllNewsFromServerState extends MapBlocState{
  Set<Marker> markers;
  List<GetNewsFromServerModel> listAllNews;
  GetAllNewsFromServerState({required this.markers, required this.listAllNews} );
}
