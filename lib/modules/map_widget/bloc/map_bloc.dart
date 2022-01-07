import 'dart:async';
import 'package:event_on_map/modules/map_widget/service/map_service.dart';
import 'package:event_on_map/modules/news/models/news.dart';
import 'package:event_on_map/modules/news/services/news_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_bloc_state.dart';

class GoogleMapBloc {
  final _streamController = StreamController<MapBlocState>();

  Stream<MapBlocState> get streamMapController => _streamController.stream;

  /// Прокидывает пустое состояние
  void emptyBloc () {
    _streamController.sink.add(MapBlocState.emptyLatLng());
  }

  /// Получение LatLng, адресса местоположения пользователя и маркера
  Future<void> getLatLngAndAddressAndMarkerUserPositionBloc(Completer<GoogleMapController> controller, [LatLng? latLngNews]) async {
    _streamController.sink.add(MapBlocState.emptyLatLng());
    try {
      Set<Marker> setUserMarker = await MapProvider.getMyMarkerProvider(controller);
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

  /// Вызов карточки показа информации по маркеру события
  void cardForMarkerBloc (GetNewsFromServerModel _dataForCard, String? address) {
    _streamController.sink.add(MapBlocState.cardForMarkerState(_dataForCard, address));
  }

  void dispose() {
    _streamController.close();
  }
}
