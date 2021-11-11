import 'package:event_on_map/create_event/bloc/create_event/create_event_bloc.dart';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'bloc/create_event_map_bloc.dart';
import 'bloc/create_event_map_bloc_state.dart';

class CreateEventMapWidget extends StatefulWidget {
  const CreateEventMapWidget({Key? key}) : super(key: key);

  @override
  _CreateEventMapWidgetState createState() => _CreateEventMapWidgetState();
}

class _CreateEventMapWidgetState extends State<CreateEventMapWidget> {
  late CreateEventMapBloc _bloc;
  late GoogleMapController _googleMapController;
  late LatLng _myPosition = LatLng(0.0, 0.0);
  Set<Marker> _setUserMarkers = {};
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
    _bloc = CreateEventMapBloc();
    _bloc.createEventGetLatLngAndAddressUserPosition();
    GoogleMapController _googleMapController;
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
        stream: _bloc.streamCreateEventMapController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _body(snapshot, context);
        },
      ),
    );
  }

  Stack _body(AsyncSnapshot snapshot, BuildContext context) {
    LatLng _position = LatLng(0.0, 0.0);
    List<Placemark> _placemark = [Placemark(street: '', subThoroughfare: '')];

    if (snapshot.data is LoadedAddressFromCoordinatesState) {
      final _data = snapshot.data as LoadedAddressFromCoordinatesState;
      _placemark = _data.placemark;
      _position = _data.position;
      _myPosition = LatLng(_position.latitude, _position.longitude);
      _getMyMarker(_myPosition, _placemark);
    }
    return Stack(
      children: [
        GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            markers: _setUserMarkers,
            initialCameraPosition: CameraPosition(
              target: _myPosition,
              zoom: 16,
            ),
            onTap: (LatLng _onTabLatLng) => _bloc.getAddressOnTab(_onTabLatLng) // получение LatLng по нажатию на карту
            ),
        _showAddress(context, _placemark, _position),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () => _bloc.createEventGetLatLngAndAddressUserPosition(),
                    child: const Icon(
                      CustomIcons.map_marker,
                      size: 30,
                    ),
                    style: buttonStyle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 300)
          ],
        )
      ],
    );
  }

  /// Вывод на экран выбранного адреса
  Column _showAddress(BuildContext context, List<Placemark> _placemark, LatLng _position) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Область/Край'),
                            Text('${_placemark.first.administrativeArea}'),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Город'),
                            Text('${_placemark.first.locality}'),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Улица/Проспект'),
                            Text('${_placemark.first.street}'),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Дом №'),
                            Text('${_placemark.first.subThoroughfare}'),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (){
                              ServiceNewEventBloc().getLatLngFromMap(_position);
                              Navigator.of(context).pop();
                            }, child: Text('Выбрать'),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }

  /// Создание маркера по нажатию на карту для CreateEvent
  void _getMyMarker(LatLng _myPosition, List<Placemark> placemark) {
    final _userMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${placemark.first.street} ${placemark.first.subThoroughfare}',
          // Название, не сохраняется адресс
          snippet: 'Выбор адреса для события'), // Тело
      position: _myPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen), // изминение маркера
    );
    _setUserMarkers = MapProvider.refreshSetProvider(
        set: _setUserMarkers, marker: _userMarker);
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
