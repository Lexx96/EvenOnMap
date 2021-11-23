import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:event_on_map/news_page/services/news_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'bloc/map_bloc.dart';
import 'bloc/map_bloc_state.dart';
import 'service/map_provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

/*
 проблема с темой карты
 сделать маркер больше и над другими маркерами
 */

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapBloc _bloc;
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _myPosition;
  Set<Marker> _setUserMarker = {};
  Set<Marker> _setNewsAddUserPosition = {};
  late List<Placemark> _placemark; // аж 5 адресов, выбрать нужный

  @override
  void initState() {
    super.initState();
    _bloc = GoogleMapBloc();
    _bloc.getLatLngAndAddressUserPosition();
    _bloc.getAllNewsFromServer();
    _choiceTheme();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.streamMapController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _bodyMapWidget(context, snapshot);
        },
      ),
    );
  }

  /// Тело страницы
  Scaffold _bodyMapWidget(BuildContext context, AsyncSnapshot snapshot) {



    if (snapshot.data is LoadedAddressFromUserPositionState) {
      final _data = snapshot.data as LoadedAddressFromUserPositionState;
      _myPosition = _data.latLngUserPosition;
      _placemark = _data.placemark;
      _getMyMarker(_myPosition, _placemark);
    } else {
      List<Placemark> _placemark = [Placemark()];
      _myPosition = LatLng(0.0, 0.0);
    }

    if (snapshot.data is GetAllNewsFromServerState) {
      final _data = snapshot.data as GetAllNewsFromServerState;
      Set<Marker> _newsMarkers = _data.markers;
      _newsMarkers.add(_setUserMarker.first);
      print(_newsMarkers);
      _setNewsAddUserPosition = _newsMarkers;
    }

    return Scaffold(
      body: GoogleMap(
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _onMapCreated();
        },
        markers: _setNewsAddUserPosition,
        initialCameraPosition: CameraPosition(
          target: _myPosition,
          zoom: 16,
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _bloc.getLatLngAndAddressUserPosition(),
                    child: const Icon(
                      CustomIcons.map_marker,
                      size: 30,
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(45, 45)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            MainNavigationRouteName.createAnEventWidget,
                            (route) => false),
                    child: Text(
                      'Создать событие',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  /// Создание маркера при получении местоположения пользователя
  void _getMyMarker(LatLng _myPosition, List<Placemark> _placemark) {
    final _userMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: _placemark.first.locality != null
              ? '${_placemark.first.street} ${_placemark.first.subThoroughfare}'
              : 'Адрес не определен',
          snippet: 'Мое местоположение'), // Тело
      position: _myPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen), // изминение маркера
    );
    _setUserMarker = MapProvider.refreshSetProvider(
        set: _setUserMarker, marker: _userMarker);
    _onMapCreated();
  }

  /// Возвращает камеру на место положение пользователя
  Future<void> _onMapCreated() async {
    final GoogleMapController controller = await _controller.future;
    if (_myPosition != LatLng(0.0, 0.0)) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _myPosition, zoom: 16),
        ),
      );
    }
  }

  /// Получение информации о ранее выбранной теме и в зависимости от этого вызов метода bloc
  Future<void> _choiceTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    String themeMap = 'assets/map_dark_theme/dark_theme.json';
    // if (AdaptiveThemeMode.system.isDark) {
    //    themeMap = 'assets/map_dark_theme/dark_theme.json';
    // } else if (AdaptiveThemeMode.system.isLight) {
    //   themeMap = 'assets/map_dark_theme/light_theme.json';
    // } else if (savedThemeMode == AdaptiveThemeMode.light) {
    //   themeMap = 'assets/map_dark_theme/light_theme.json';
    // } else if (savedThemeMode == AdaptiveThemeMode.dark) {
    //   themeMap = 'assets/map_dark_theme/dark_theme.json';
    // }

    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(themeMap);
  }
}
