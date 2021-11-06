
import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:geolocator/geolocator.dart';

class NewEventBlocState {
  NewEventBlocState();
  factory NewEventBlocState.emptyEvent() = EventEmptyBlocState;
  factory NewEventBlocState.loadingEvent() = EventLoadingBlocState;
  factory NewEventBlocState.loadedEvent(NewEventModel newEventModel) = EventLoadedBlocState;
  factory NewEventBlocState.getLatLngLoading() = GetLatLngLoadingState;
  factory NewEventBlocState.getLatLngLoaded(Position getPosition) = GetLatLngLoadedState;
  factory NewEventBlocState.postEvenErrorSendingServer() = PostEvenErrorSendingServerState;
  factory NewEventBlocState.postEventNotRegisteredSendingServer() = PostEventNotRegisteredSendingServerState;
}

class EventEmptyBlocState extends NewEventBlocState {}

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
