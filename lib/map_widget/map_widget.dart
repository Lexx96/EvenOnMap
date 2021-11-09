import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'bloc/map_bloc.dart';
import 'bloc/map_bloc_state.dart';
import 'service/map_provider.dart';

/*
сделать появление маркера по нажатию на карту
и перенаправление на этот метод с страницы создания события

потом появление адреса и подтверждение

 */

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // Класс с bloc
  late GoogleMapBloc _bloc;

  // контроллер для GoogleMap
  late GoogleMapController _googleMapController;

  // Позиция пользователя получаем данные от репозитория
  late LatLng _myPosition;

  // сохраняются маркер положения пользователя
  Set<Marker> _setUserMarkers = {};

  // сохраняются маркеры нажатия на карту
  Set<Marker> _setOnTabMarkers = {};

  // В _placemark после инициализации приходит адрес местоположения согласно LatLng
  late List<Placemark> _placemark;

  ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    overlayColor: MaterialStateProperty.all(Colors.grey),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    minimumSize: MaterialStateProperty.all(Size(45, 45)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: const BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ) // цвет бордера
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
    return StreamBuilder(
      stream: _bloc.streamMapController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return _bodyMapWidget(context, snapshot);
      },
    );
  }

  /// Тело страницы
  Scaffold _bodyMapWidget(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data is LoadedLatLngAndAddress) {
      final _data = snapshot.data as LoadedLatLngAndAddress;
      _myPosition = LatLng(_data.position.latitude, _data.position.longitude);
      _placemark = _data.placemark;
      _getMyMarker(_myPosition, _placemark);
    } else {
      // Инициализировал переменную _placemark
      _placemark = [];

      // Изначальное положение маркера в формате LatLng
      _myPosition = LatLng(0.0, 0.0);
    }
    if (snapshot.data is LoadedAddressFromCoordinates) {
      final _data = snapshot.data as LoadedAddressFromCoordinates;
      final _address = _data.addresses;
      final _onTabLatLng = _data.onTabLatLng;
      _onTabMarker(_address, _onTabLatLng);
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: (snapshot.data is LoadedAddressFromCoordinates) ? _setOnTabMarkers : _setUserMarkers,
            initialCameraPosition: CameraPosition(
              target: _myPosition,
              zoom: 16,
            ),
            onTap: (LatLng onTabLatLng) => _bloc.getAddressOnTab(onTabLatLng), // получение LatLng по нажатию на карту
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                MainNavigationRouteName.createAnEventWidget, (route) => false),
            child: Icon(
              Icons.add,
              size: 30,
            ),
            style: buttonStyle,
          ),
          const SizedBox(
            width: 10,
          ),
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
    print(_userMarker);
    _onMapCreated(_googleMapController);
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
    print('111111111111111111111');
    print(_onTabMarker);
  }
}
