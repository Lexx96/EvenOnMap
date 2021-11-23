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
        await MapProvider.getAddressFromLatLongGPS(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        LatLng position = LatLng(getPositionFromGPS.latitude, getPositionFromGPS.longitude);
        _streamController.sink.add(MapBlocState.loadedAddressFromCoordinates(
            _placemark, position));
      },
    );
  }


  void getAllNewsFromServer () async {
    List<GetNewsFromServerModel> listAllNews = await NewsProvider().getAllNewsFromServer();
    Set<Marker> newsMarkers = {};

    for (int i = 0; i < listAllNews.length; i++) {
        if (listAllNews.asMap().containsKey(i)) {
          Address thisAddress = await MapProvider.getAddressFromCoordinates(LatLng(listAllNews[i].lat, listAllNews[i].lng));
          Marker _marker = Marker(
            markerId: MarkerId('${listAllNews[i].id}'),
            infoWindow: InfoWindow(
                title: thisAddress.subThoroughfare != null ? '${thisAddress.thoroughfare} ${thisAddress.subThoroughfare}' : '${thisAddress.thoroughfare} ',
                snippet: listAllNews[i].title),
            position: LatLng(listAllNews[i].lat, listAllNews[i].lng),
          );
          newsMarkers.add(_marker);
        }
    }
    _streamController.sink.add(MapBlocState.getAllNewsFromServerState(markers: newsMarkers, listAllNews: listAllNews));
  }

  void dispose() {
    _streamController.close();
  }
}
