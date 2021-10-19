


import 'package:event_on_map/create_event/models/post_event_model.dart';

class NewEventBlocState {
  NewEventBlocState();
  factory NewEventBlocState.emptyEvent() = EventEmptyBloc;
  factory NewEventBlocState.loadingEvent() = EventLoadingBloc;
  factory NewEventBlocState.loadedEvent(List<NewEventModel> newEventModel) = EventLoadedBloc;
  factory NewEventBlocState.getLatLng() = GetLatLng;
}

class EventEmptyBloc extends NewEventBlocState {}

class EventLoadingBloc extends NewEventBlocState {}

class EventLoadedBloc extends NewEventBlocState {
  List<NewEventModel> newEventModel;
  EventLoadedBloc(this.newEventModel);
}

class GetLatLng extends NewEventBlocState {}
