import 'dart:async';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:event_on_map/news_page/services/news_provider.dart';
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
      double lat, double lng) async {
    try {
      return await MapRepository.getAddressFromLatLong(lat, lng);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Определение адреса по LatLng [package:geocoder]
  static Future<Address> getAddressFromCoordinates(LatLng onTabLatLng) async {
    try {
      List<Address> addresses = await MapRepository.getAddress(onTabLatLng);
      Address addressesInOnTab = addresses.first;
      return addressesInOnTab;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Обновление Set<Marker> для обновления маркеров на карте
  static Set<Marker> refreshSetProvider(
      {required Set<Marker> set, required Marker marker}) {
    set.clear();
    set.add(marker);
    return set;
  }
  /// Получение новостей с сервера и создание маркеров новостей
  static Future<Set<Marker>> getAllNewsFromServerProvider() async {
    List<GetNewsFromServerModel> listAllNews =
        await NewsProvider().getAllNewsFromServer();
    Set<Marker> newsMarkers = {};
    try {
      for (int i = 0; i < listAllNews.length; i++) {
        if (listAllNews.asMap().containsKey(i)) {
          Address thisAddress = await getAddressFromCoordinates(
              LatLng(listAllNews[i].lat, listAllNews[i].lng));
          Marker _marker = Marker(
            markerId: MarkerId('${listAllNews[i].id}'),
            infoWindow: InfoWindow(
                title: thisAddress.subThoroughfare != null
                    ? '${thisAddress.thoroughfare} ${thisAddress.subThoroughfare}'
                    : '${thisAddress.thoroughfare} ',
                snippet: listAllNews[i].title),
            position: LatLng(listAllNews[i].lat, listAllNews[i].lng),
          );
          newsMarkers.add(_marker);
        }
      }
      return newsMarkers;
    } catch (e) {
      throw Exception(e);
    }
  }


  /// Создание маркера при получении местоположения пользователя
  static Future<Set<Marker>> getMyMarkerProvider() async {

    try{
      Position getPositionUserFromGPS = await determinePosition();

      List<Placemark> _placemark = await getAddressFromLatLongGPS(getPositionUserFromGPS.latitude, getPositionUserFromGPS.longitude);
      LatLng _myPosition = LatLng(getPositionUserFromGPS.latitude, getPositionUserFromGPS.longitude);
      Set<Marker> _setUserMarker = {};

      final _userMarker = Marker(
        markerId: MarkerId(''),
        infoWindow: InfoWindow(
            title: _placemark.first.locality != null
                ? '${_placemark.first.street} ${_placemark.first.subThoroughfare}'
                : 'Адрес не определен',
            snippet: 'Мое местоположение'),
        position: _myPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen), // изминение маркера
      );
      _setUserMarker.add(_userMarker);
      return _setUserMarker;
    }catch(e){
      throw Exception(e);
    }
  }

  /// Возвращает камеру на место положение пользователя
  static Future<void> onMapCreatedProvider(Completer<GoogleMapController> _controller) async {

    try{
      Position getPositionUserFromGPS = await determinePosition();
      LatLng _myPosition = LatLng(getPositionUserFromGPS.latitude, getPositionUserFromGPS.longitude);

      final GoogleMapController controller = await _controller.future;
      if (_myPosition != LatLng(0.0, 0.0)) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _myPosition, zoom: 16),
          ),
        );
      }
    }catch(e){
      throw Exception(e);
    }
  }
}
