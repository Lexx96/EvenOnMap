import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/themes/my_light_theme.dart';
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

class _MapWidgetState extends State<MapWidget> {

  late GoogleMapBloc _bloc;
  late GoogleMapController _googleMapController;
  late LatLng _myPosition;
  Set<Marker> _setUserMarkers = {};
  Set<Marker> _setOnTabMarkers = {};
  late List<Placemark> _placemark;
  ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ColorsLightTheme.color1),
    overlayColor: MaterialStateProperty.all(Colors.white),
    minimumSize: MaterialStateProperty.all(Size(45, 45)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          ),
    ),
  );

  @override
  void initState() {
    super.initState();
    GoogleMapController _googleMapController;
    _bloc = GoogleMapBloc();
    _bloc.getLatLngAndAddressUserPosition();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _googleMapController.dispose();
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
      // bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  /// Тело страницы
  Scaffold _bodyMapWidget(BuildContext context, AsyncSnapshot snapshot) {

    _choiceTheme();  // из за него ошибка

    if (snapshot.data is LoadedLatLngAndAddressState) {
      final _data = snapshot.data as LoadedLatLngAndAddressState;
      _myPosition = LatLng(_data.position.latitude, _data.position.longitude);
      _placemark = _data.placemark;
      _getMyMarker(_myPosition, _placemark);
    } else {
      _placemark = [];
      _myPosition = LatLng(0.0, 0.0);
    }

    if (snapshot.data is LoadedAddressFromCoordinatesState) {
      final _data = snapshot.data as LoadedAddressFromCoordinatesState;
      final _address = _data.addresses;
      final _onTabLatLng = _data.onTabLatLng;
      _onTabMarker(_address, _onTabLatLng);
    }

    if (snapshot.data is GetMapThemeState) {
      final _data = snapshot.data as GetMapThemeState;
      final _mapStyle = _data.mapStyle;
      _mapDarkTheme(_mapStyle);
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: (snapshot.data is LoadedAddressFromCoordinatesState) ? _setOnTabMarkers : _setUserMarkers,
            initialCameraPosition: CameraPosition(
              target: _myPosition,
              zoom: 16,
            ),
            onTap: (LatLng _onTabLatLng) => _bloc.getAddressOnTab(_onTabLatLng), // получение LatLng по нажатию на карту
          ),
        ],
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
                    style: buttonStyle,
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
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                        MainNavigationRouteName.createAnEventWidget, (route) => false),
                    child:
                    Text('Создать событие', style: TextStyle(fontSize: 18),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ColorsLightTheme.color3),
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
  void _getMyMarker(LatLng _myPosition, List<Placemark> placemark) {
    final _userMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${placemark.first.street} ${placemark.first.subThoroughfare}', // Название, не сохраняется адресс
          snippet: 'Здарова'), // Тело
      position: _myPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen), // изминение маркера
    );
    _setUserMarkers = MapProvider.refreshSetProvider(set: _setUserMarkers, marker: _userMarker);
    _onMapCreated(_googleMapController);
  }

  /// Получение информации о ранее выбранной теме и в зависимости от этого вызов метода bloc
  Future<void> _choiceTheme() async {

    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    if (AdaptiveThemeMode.system.isDark) {
    _bloc.changeMapMode('assets/map_dark_theme/dark_theme.json');
    }
    else if (AdaptiveThemeMode.system.isLight) {
    _bloc.changeMapMode('assets/map_dark_theme/light_theme.json');
    }

    else if (savedThemeMode == AdaptiveThemeMode.light) {
      _bloc.changeMapMode('assets/map_dark_theme/light_theme.json');
    }
    else if (savedThemeMode == AdaptiveThemeMode.dark) {
      _bloc.changeMapMode('assets/map_dark_theme/dark_theme.json');
    }
  }

  /// Смена темы карты
  void _mapDarkTheme (String mapStyle) {
    _googleMapController.setMapStyle(mapStyle);
  }

  /// Возвращает камеру на место положение пользователя
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    if (_myPosition != LatLng(0.0, 0.0)) {
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _myPosition, zoom: 16),
        ),
      );
    }
  }

  /// Создание маркера по нажатию на карту
  void _onTabMarker(Address address, LatLng _onTabLatLng) async {
    final _onTabMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${address.thoroughfare} ${address.subThoroughfare}', // Название
          snippet: 'Создание'), // Тело
      position: _onTabLatLng,
    );
    _setOnTabMarkers =  MapProvider.refreshSetProvider(set: _setOnTabMarkers, marker: _onTabMarker);
  }
}
