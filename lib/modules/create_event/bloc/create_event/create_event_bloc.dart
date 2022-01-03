import 'dart:async';
import 'dart:io';
import 'package:event_on_map/modules/create_event/services/create_event/create_event_servise.dart';
import 'package:event_on_map/modules/map_widget/service/map_service.dart';
import 'package:event_on_map/modules/userProfile/service/user_profile_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'create_event_bloc_state.dart';

class CreateEventBloc {

  final _streamController = StreamController<NewEventBlocState>();

  Stream<NewEventBlocState> get streamEventController =>
      _streamController.stream;

  void emptyCreateEvent() {
    _streamController.sink.add(NewEventBlocState.emptyCreateEventState());
  }


  /// Размещение нового события на сервер и получение данных
  Future<void> loadingPostEventBloc({
    String? title,
    String? description,
    String? lat,
    String? lng,
    required List<File?> listImages,
  }) async {
    _streamController.sink.add(NewEventBlocState.loadingEventState());

    PostNewEventProvider()
        .postNewEvent(
      title: title,
      description: description,
      lat: lat,
      lng: lng,
    ).then(
      (responseModelNewEvent) async {
          await PostNewEventProvider.postNewEventImages(listImages: listImages, idEvent: responseModelNewEvent.id);
        _streamController.sink
            .add(NewEventBlocState.loadedEventState(responseModelNewEvent));
      },
    ).catchError(
      (exception) {
        if (exception is PostEvenErrorSendingServerException) {
          _streamController.sink
              .add(NewEventBlocState.postEvenErrorSendingServerState());
        } else if (exception is PostEventNotRegisteredSendingServerException) {
          _streamController.sink
              .add(NewEventBlocState.postEventNotRegisteredSendingServerState());
        } else {
          print('Ошибка выполнения запроса регистрации');
        }
      },
    );
  }

  /// Получение адресса местоположения пользователя
  void getLatLngAndAddressUserPosition() async {
    await MapProvider.determinePosition().then(
          (getPositionFromGPS) async {
            LatLng _initialLatLng = LatLng(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        List<Placemark> _placemark =
        await MapProvider.getAddressFromLatLongGPS(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        _streamController.sink.add(NewEventBlocState.getLatLngAndAddressState(placemark: _placemark, initialLatLng: _initialLatLng),
        );
      },
    );
  }

  /// Определение адреса по LatLng [package:geocoder]
  void getLatLngAndAddressFromMap(LatLng _onTabLatLng) async {
    try{
      List<Placemark> _placemark = await MapProvider.getAddressFromLatLongGPS(
          _onTabLatLng.latitude, _onTabLatLng.longitude);
      _streamController.sink.add(
        NewEventBlocState.getLatLngAndAddressState(placemark: _placemark, initialLatLng: _onTabLatLng),
      );
    }catch(e){
      print(e);
    }
  }

  /// Получение данных о пользователе из SharedPreferencesBloc
  void isRegistrationFromSharedPreferencesBloc() async {
    try {
      final userDataFromSharedPreferences = await UserProfileProvider().getDataFromSharedPreferencesProvider();
      if(userDataFromSharedPreferences['userName'] == null || userDataFromSharedPreferences['userSurname'] == null) {
        _streamController.sink.add(NewEventBlocState.isRegistrationUserState(false));
      }else {
        _streamController.sink.add(NewEventBlocState.isRegistrationUserState(true));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Открытие виджета с картой для выбора место события на карте
  void openGoogleMapState () {
    _streamController.add(NewEventBlocState.openGoogleMapState());
  }

  /// Получение листа изображений от ImageWidget
  void getListImagesFromImageWidgetBloc(List<File?> _images) {
    _streamController.add(NewEventBlocState.getListImagesFromImageWidgetBloc(_images));
  }

  void dispose() {
    _streamController.close();
  }
}

class PostEvenErrorSendingServerException implements Exception {}

class PostEventNotRegisteredSendingServerException implements Exception {}
