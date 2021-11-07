import 'package:event_on_map/create_event/services/create_event/create_event_provider.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'bloc/map_bloc.dart';
import 'bloc/map_bloc_state.dart';

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

  // сохраняются добавленные маркеры
  Set<Marker> markers = {};

  // После инициализации приходит адрес местоположения согласно LatLng
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
    _bloc.getLatLngAndAddressOnMap();
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
    if (snapshot.data is LoadedLatLng) {
      final _data = snapshot.data as LoadedLatLng;
      _myPosition = LatLng(_data.position.latitude, _data.position.longitude);
      _getMyMarker(_myPosition, _data.placemark);
      _placemark = _data.placemark;
    } else {
      _placemark = [];
      _myPosition = LatLng(0.0, 0.0);
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: _myPosition,
              zoom: 16,
            ),
            onTap: (LatLng position) {
              _onTabMarker(LatLng(position.latitude, position.longitude), _placemark);
            }, // получение LatLng по нажатию на карту
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
            onPressed: () => _getMyMarker(_myPosition, _placemark),
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

  /// Создание маркера по нажатию на карту
  void _onTabMarker(LatLng _position, List<Placemark> placemark) {
    final myMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${placemark.first.street} ${placemark.first.subThoroughfare}',
          // Название
          snippet: 'Тест'), // Тело
      position: _position,
    );
    setState(() {
      markers.add(myMarker);
    });
    _onMapCreated(_googleMapController);
  }

  /// Создание маркера при получении местоположения пользователя
  void _getMyMarker(LatLng _myPosition, List<Placemark> placemark) {
    final myMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${placemark.first.street} ${placemark.first.subThoroughfare}',
          // Название
          snippet: 'Здарова'), // Тело
      position: _myPosition,
    );
    markers.add(myMarker);
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
}
