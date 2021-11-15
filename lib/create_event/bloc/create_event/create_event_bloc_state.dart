import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewEventBlocState {
  NewEventBlocState();
  factory NewEventBlocState.emptyCreateEventState() = EmptyCreateEventState;
  factory NewEventBlocState.loadingEventState() = EventLoadingBlocState;
  factory NewEventBlocState.openGoogleMapState() = OpenGoogleMapState;
  factory NewEventBlocState.loadedEventState(NewEventModel newEventModel) = EventLoadedBlocState;
  factory NewEventBlocState.postEvenErrorSendingServerState() = PostEvenErrorSendingServerState;
  factory NewEventBlocState.postEventNotRegisteredSendingServerState() = PostEventNotRegisteredSendingServerState;
  factory NewEventBlocState.getLatLngAndAddressState({required List<Placemark> placemark, required LatLng initialLatLng}) = GetLatLngAndAddressState;
  // factory NewEventBlocState.getLatLngAndAddressFromMapState({required List<Placemark> placemark, required LatLng onTabLatLng}) = GetLatLngFromMapState;
}
class EmptyCreateEventState extends NewEventBlocState {}

class OpenGoogleMapState extends NewEventBlocState {}

class EventLoadingBlocState extends NewEventBlocState {}

class EventLoadedBlocState extends NewEventBlocState {
  NewEventModel newsEventModel;
  EventLoadedBlocState(this.newsEventModel);
}

class PostEvenErrorSendingServerState extends NewEventBlocState {}

class PostEventNotRegisteredSendingServerState extends NewEventBlocState {}

class GetLatLngAndAddressState extends NewEventBlocState {
  List<Placemark> placemark;
  LatLng initialLatLng;
  GetLatLngAndAddressState({required this.placemark, required this.initialLatLng});
}

// class GetLatLngFromMapState extends NewEventBlocState {
//   List<Placemark> placemark;
//   LatLng onTabLatLng;
//   GetLatLngFromMapState({required this.placemark, required this.onTabLatLng});
// }
