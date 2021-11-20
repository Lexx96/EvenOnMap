import 'dart:async';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:event_on_map/map_widget/service/map_repository.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:event_on_map/news_page/services/news_provider.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_bloc_state.dart';

class GoogleMapBloc {
  final _streamController = StreamController<MapBlocState>();

  Stream<MapBlocState> get streamMapController => _streamController.stream;

  /// Получение LatLng и адресса местоположения пользователя
  void getLatLngAndAddressUserPosition() async {
    _streamController.sink.add(MapBlocState.emptyLatLng());
    await MapProvider.determinePosition().then(
          (getPositionFromGPS) async {
        List<Placemark> _placemark =
        await MapProvider.getAddressFromLatLongGPS(
            getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        LatLng position = LatLng(
            getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        _streamController.sink.add(MapBlocState.loadedLatLngAndAddress(
            position, _placemark));
      },
    );
  }

  /// Определение адреса по LatLng [package:geocoder]
  void getAddressOnTab(LatLng onTabLatLng) async {
    await MapProvider.getAddressFromCoordinates(onTabLatLng).then(
          (addressesInOnTab) async {
        List<Placemark> _placemark =
        await MapProvider.getAddressFromLatLongGPS(
            onTabLatLng.latitude, onTabLatLng.longitude);
        _streamController.sink.add(MapBlocState.loadedLatLngAndAddress(
            onTabLatLng, _placemark));
      },
    );
  }

  /// Изминение темы карты на темную
  void changeMapMode(String path) async {
    return await MapRepository.getJsonFile(path).then((mapStyle) {
      _streamController.sink.add(MapBlocState.getMapThemeState(mapStyle));
    },);
  }


  // перенести из блока тк не управляют состоянием
  /// Получение всех новостей с сервера
  Future<List<GetNewsFromServerModel>> getAllNews() async{
    List<GetNewsFromServerModel> jsonNewsModel =  await NewsProvider().getAllNewsFromServer();
    return jsonNewsModel;
  }

  /// Получение адресов по LatLng для вывода маркеров новостей на карту
  Future <Address> getAllAddress (LatLng latLng) async {
    return await MapProvider.getAddressFromCoordinates(latLng);
  }

void dispose() {
  _streamController.close();
}}
