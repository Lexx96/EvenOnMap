import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_repository.dart';

class MapProvider {


  // Разбить на методы
  /// Проверка доступа к GPS модулю и определение Position
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
        return Future.error(
            'Разрешение на определение местоположения не предоставленно');
      }
    }
    // Если доступ на получение геолокации не предоставлен
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Доступ на получение геолокации не предоставлен');
    }
    // Если все разрешения предоставленны, получает местоположение
    return await MapRepository.determinePositionGPS();
  }

  /// Определение адреса по Position [package:geocoding]
  static Future<List<Placemark>> getAddressFromLatLongGPS(
      Position position) async {
    try {
      return await MapRepository.getAddressFromLatLong(position);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Определение адреса по LatLng [package:geocoder]
  static Future<Address> getAddressFromCoordinates(LatLng onTabLatLng) async {
    try {
      List<Address> addresses =
          await MapRepository.getAddress(onTabLatLng);
      Address addressesInOnTab = addresses.first;
      return addressesInOnTab;
    } catch (e) {
      throw Exception(e);
    }
  }

// перенести методы в папку с картой блять!

  /// Обновление Set<Marker> для обновления маркеров на карте
  static Set<Marker> refreshSetProvider(
      {required Set<Marker> set, required Marker marker}) {
    set.clear();
    set.add(marker);
    return set;
  }
}
