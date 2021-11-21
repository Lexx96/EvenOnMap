import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
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
 появляется маркер с запозданием
 проблема с темой карты
 убрать сетстейт
 на всех новостях один адресс
 сделать маркер больше и над другими маркерами
 */

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapBloc _bloc;
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _myPosition;
  Set<Marker> _setUserMarkers = {};
  Set<Marker> _setOnTabMarkers = {};
  Set<Marker> _setNewsAddUserPosition = {};
  Iterable _setAllNewsMarkers = [];
  late Address _address;

  @override
  void initState() {
    super.initState();
    _bloc = GoogleMapBloc();
    _bloc.getLatLngAndAddressUserPosition();
    _getNewsFromServer();
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

    // _choiceTheme();  // из за него ошибка

    if (snapshot.data is LoadedAddressFromUserPositionState) {
      final _data = snapshot.data as LoadedAddressFromUserPositionState;
      _myPosition = _data.latLngUserPosition;
      _address = _data.addressUserPosition;
      _getMyMarker(_myPosition, _address);
    } else {
      _address = Address(coordinates: Coordinates(0.0, 0.0));
      _myPosition = LatLng(0.0, 0.0);
    }

    if (snapshot.data is GetMapThemeState) {
      final _data = snapshot.data as GetMapThemeState;
      final _mapStyle = _data.mapStyle;
      _mapDarkTheme(_mapStyle);
    }

    return Scaffold(
      body: GoogleMap(
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        _onMapCreated();
        } ,
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
  void _getMyMarker(LatLng _myPosition, Address address) {
    final _userMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${address.thoroughfare} ${address.subThoroughfare}', // Название, не сохраняется адресс
          snippet: 'Мое местоположение'), // Тело
      position: _myPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen), // изминение маркера
    );
    _setUserMarkers = MapProvider.refreshSetProvider(
        set: _setUserMarkers, marker: _userMarker);
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

  /// Создание маркера из списка новостей
  void _getNewsFromServer() async {
    List<GetNewsFromServerModel> allNews = await _bloc.getAllNews();

    for (int i = 0; i <= allNews.length; i++) {
      Address addressFrom =
          await _bloc.getAllAddress(LatLng(allNews[i].lat, allNews[i].lng));
      print('111111111111111111111111111111');
      print(allNews[i].title);
      print(addressFrom.thoroughfare);

      Iterable _markers = Iterable.generate(
        allNews.length,
        (index) {
          print(index);
          return Marker(
            markerId: MarkerId("marker$index"),
            infoWindow: InfoWindow(
                title:
                    '${addressFrom.thoroughfare} ${addressFrom.subThoroughfare}', // приходит null. Хотя адреса в переменной есть
                snippet: allNews[index].title),
            position: LatLng(allNews[index].lat, allNews[index].lng),
          );
        },
      );

      setState(() {
        _setAllNewsMarkers = _markers;
        _setNewsAddUserPosition = Set.from(_setAllNewsMarkers).cast<Marker>();
        _setNewsAddUserPosition.add(_setUserMarkers.first);
        _setNewsAddUserPosition.add(_setOnTabMarkers.last); // просто пустой сет, т.к. появляется маркер с запозданием и последний маркер(пользователя не видно)
      });
    }
  }

  /// Получение информации о ранее выбранной теме и в зависимости от этого вызов метода bloc
  Future<void> _choiceTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    if (AdaptiveThemeMode.system.isDark) {
      _bloc.changeMapMode('assets/map_dark_theme/dark_theme.json');
    } else if (AdaptiveThemeMode.system.isLight) {
      _bloc.changeMapMode('assets/map_dark_theme/light_theme.json');
    } else if (savedThemeMode == AdaptiveThemeMode.light) {
      _bloc.changeMapMode('assets/map_dark_theme/light_theme.json');
    } else if (savedThemeMode == AdaptiveThemeMode.dark) {
      _bloc.changeMapMode('assets/map_dark_theme/dark_theme.json');
    }
  }

  /// Смена темы карты
  Future<void> _mapDarkTheme(String mapStyle) async {
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(mapStyle);
  }
}
