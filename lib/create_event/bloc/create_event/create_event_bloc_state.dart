
import 'package:event_on_map/create_event/models/post_event_model.dart';

class NewEventBlocState {
  NewEventBlocState();
  factory NewEventBlocState.emptyEvent() = EventEmptyBloc;
  factory NewEventBlocState.loadingEvent() = EventLoadingBloc;
  factory NewEventBlocState.loadedEvent(NewEventModel newEventModel) = EventLoadedBloc;
  factory NewEventBlocState.getLatLng() = GetLatLng;
  factory NewEventBlocState.postEvenErrorSendingServer() = PostEvenErrorSendingServer;
  factory NewEventBlocState.postEventNotRegisteredSendingServer() = PostEventNotRegisteredSendingServer;
}

class EventEmptyBloc extends NewEventBlocState {}

class EventLoadingBloc extends NewEventBlocState {}

class EventLoadedBloc extends NewEventBlocState {
  NewEventModel newEventModel;
  EventLoadedBloc(this.newEventModel);
}

class GetLatLng extends NewEventBlocState {}

class PostEvenErrorSendingServer extends NewEventBlocState {}

class PostEventNotRegisteredSendingServer extends NewEventBlocState {}
