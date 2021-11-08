import 'dart:convert';

import 'package:event_on_map/create_event/bloc/create_event/create_event_bloc.dart';
import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import 'create_event_repository.dart';

class PostNewEventProvider {

  /// Размещение нового события на сервер
  Future <NewEventModel> postNewEvent({
    String? title,
    String? description,
    String? lat,
    String? lng,
}
  ) async {
    final _newEventModel = NewEventModel(
      title: title,
      description: description,
      lat: lat,
      lng: lng,
    ).toJson();

    final Response response =
        await PostEventRepository.postNewEvent(_newEventModel);

    NewEventModel newEventModel = NewEventModel();
    if (response.statusCode == 201) {
      try {
        final newJSonModelList = jsonDecode(response.body) as Map<String, dynamic>;
        final newJSonModel = NewEventModel.fromJson(newJSonModelList);
        return newJSonModel;
      } catch (error) {
        print('Ошибка запроса на размещение события $error');
        return newEventModel;
      }

      /// вынести классы ошибок в отдельный файл
    } else if(response.statusCode == 400){
      throw PostEvenErrorSendingServerException;
    } else if(response.statusCode == 500){
      throw PostEventNotRegisteredSendingServerException;
    } else{
        return newEventModel;
    }
  }

  // Разбить на методы
   /// Проверка доступа к GPS модулю и определение координат
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверка включено ли определение местоположения
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Геолокация отключена');
    }

    // Запрос на доступ к геолокации
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Разрешение на определение местоположения не предоставленно');
      }
    }

    // Если доступ на получение геолокации не предоставлен
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Доступ на получение геолокации не предоставлен');
    }

    // Если все разрешения предоставленны, получает местоположение
    return await PostEventRepository.determinePositionGPS();
  }

  /// Определение адреса по Position [package:geolocator]
  static Future<List<Placemark>> getAddressFromLatLongGPS (Position position) async {
    try{
      return await PostEventRepository.getAddressFromLatLong(position);
    }catch(e){
      throw Exception(e);
    }
  }

  /// Определение адреса по LatLng [package:geolocator]
  static Future<Address> getAddressFromCoordinates (LatLng onTabLatLng) async {
    try{
      List<Address> addresses = await PostEventRepository.getAddress(onTabLatLng);
      Address addressesInOnTab = addresses.first;
      return addressesInOnTab;
    }catch(e){
      throw Exception(e);
    }
  }





  // перенести методы в папку с картой блять!



  /// Обновление Set<Marker> для обновления маркеров на карте
  static Set<Marker> refreshSetProvider ({required Set<Marker> set, required Marker marker}) {
    set.add(marker);
    return set;
  }

}
