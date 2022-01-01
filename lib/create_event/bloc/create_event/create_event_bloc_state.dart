import 'dart:io';

import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewEventBlocState {
  NewEventBlocState();
  factory NewEventBlocState.emptyCreateEventState() = EmptyCreateEventState;
  factory NewEventBlocState.loadingEventState() = EventLoadingBlocState;
  factory NewEventBlocState.openGoogleMapState() = OpenGoogleMapState;
  factory NewEventBlocState.isRegistrationUserState(bool isIsRegistration) = IsRegistrationUserState;
  factory NewEventBlocState.getListImagesFromImageWidgetBloc(List<File?> listImages) = GetListImagesFromImageWidgetState;
  factory NewEventBlocState.loadedEventState(NewEventModel newEventModel) = EventLoadedBlocState;
  factory NewEventBlocState.postEvenErrorSendingServerState() = PostEvenErrorSendingServerState;
  factory NewEventBlocState.postEventNotRegisteredSendingServerState() = PostEventNotRegisteredSendingServerState;
  factory NewEventBlocState.getLatLngAndAddressState({required List<Placemark> placemark, required LatLng initialLatLng}) = GetLatLngAndAddressState;
}
class EmptyCreateEventState extends NewEventBlocState {}

class OpenGoogleMapState extends NewEventBlocState {}

class EventLoadingBlocState extends NewEventBlocState {}

class IsRegistrationUserState extends NewEventBlocState {
  bool isIsRegistration;
  IsRegistrationUserState(this.isIsRegistration);
}

class GetListImagesFromImageWidgetState extends NewEventBlocState {
  List<File?> listImages;
  GetListImagesFromImageWidgetState(this.listImages);
}

class EventLoadedBlocState extends NewEventBlocState {
  NewEventModel newsEventModel;
  EventLoadedBlocState(this.newsEventModel);
} // можно убрать передаваемую новость newsEventModel

class PostEvenErrorSendingServerState extends NewEventBlocState {}

class PostEventNotRegisteredSendingServerState extends NewEventBlocState {}

class GetLatLngAndAddressState extends NewEventBlocState {
  List<Placemark> placemark;
  LatLng initialLatLng;
  GetLatLngAndAddressState({required this.placemark, required this.initialLatLng});
}
