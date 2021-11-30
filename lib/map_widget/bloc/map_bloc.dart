import 'dart:async';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:event_on_map/news_page/services/news_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_bloc_state.dart';

class GoogleMapBloc {
  final _streamController = StreamController<MapBlocState>();

  Stream<MapBlocState> get streamMapController => _streamController.stream;

  /// Получение LatLng и адресса местоположения пользователя
  void getLatLngAndAddressUserPositionBloc(Completer<GoogleMapController> controller, [LatLng? latLngNews]) async {
    _streamController.sink.add(MapBlocState.emptyLatLng());
    try {
      Set<Marker> setUserMarker = await MapProvider.getMyMarkerProvider();
      await MapProvider.onMapCreatedProvider(controller, latLngNews);
      _streamController.sink
          .add(MapBlocState.loadedAddressFromUserPositionState(setUserMarker));
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Получение новостей с сервера и создание маркеров новостей
  void getAllNewsFromServerBloc() async {
    try {
      List<GetNewsFromServerModel> listAllNews =
          await NewsProvider().getAllNewsFromServer();
      MapProvider.getAllNewsFromServerProvider().then(
        (setNewsMarkers) {
          _streamController.sink.add(MapBlocState.getAllNewsFromServerState(
              markers: setNewsMarkers, listAllNews: listAllNews));
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Чтение последнего местоположения пользователя
  void readMyLastPositionBloc () async{
    try{
      final LatLng? myLastPosition = await MapProvider.readMyLastPosition();
      _streamController.sink.add(MapBlocState.readMyLastPositionState(myLastPosition));
    }catch(e){
      throw Exception(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
