import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewEventBlocState {
  NewEventBlocState();
  factory NewEventBlocState.loadingEvent() = EventLoadingBlocState;
  factory NewEventBlocState.loadedEvent(NewEventModel newEventModel) = EventLoadedBlocState;
  factory NewEventBlocState.postEvenErrorSendingServer() = PostEvenErrorSendingServerState;
  factory NewEventBlocState.postEventNotRegisteredSendingServer() = PostEventNotRegisteredSendingServerState;
  factory NewEventBlocState.getLatLngInitialState(List<Placemark> placemark, LatLng initialLatLng) = GetLatLngInitialState;
  factory NewEventBlocState.getLatLngFromMapState({required List<Placemark> placemark, required LatLng onTabLatLng}) = GetLatLngFromMapState;
}

class EventLoadingBlocState extends NewEventBlocState {}

class EventLoadedBlocState extends NewEventBlocState {
  NewEventModel newsEventModel;
  EventLoadedBlocState(this.newsEventModel);
}

class GetLatLngLoadingState extends NewEventBlocState {}

class GetLatLngLoadedState extends NewEventBlocState {
  late Position getPosition;
  GetLatLngLoadedState(this.getPosition);
}

class PostEvenErrorSendingServerState extends NewEventBlocState {}

class PostEventNotRegisteredSendingServerState extends NewEventBlocState {}

class GetLatLngInitialState extends NewEventBlocState {
  List<Placemark> placemark;
  LatLng initialLatLng;
  GetLatLngInitialState(this.placemark, this.initialLatLng);
}

class GetLatLngFromMapState extends NewEventBlocState {
  List<Placemark> placemark;
  LatLng onTabLatLng;
  GetLatLngFromMapState({required this.placemark, required this.onTabLatLng});
}
