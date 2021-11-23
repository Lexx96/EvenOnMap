import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _bloc = GoogleMapBloc();
    _bloc.getLatLngAndAddressUserPositionBloc(_controller);
    _bloc.getAllNewsFromServerBloc();
    MapProvider.choiceMapTheme(_controller);
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
      _setUserMarker.add(_data.setUserMarker.first);
    } else {
      _myPosition = LatLng(0.0, 0.0);
    }

    if (snapshot.data is GetAllNewsFromServerState) {
      final _data = snapshot.data as GetAllNewsFromServerState;
      Set<Marker> _newsMarkers = _data.markers;
      _newsMarkers.add(_setUserMarker.first);
      _setNewsAddUserPosition = _newsMarkers;
    }

    return Scaffold(
      body: GoogleMap(
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          await MapProvider.onMapCreatedProvider(_controller);
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
                    onPressed: () => _bloc.getLatLngAndAddressUserPositionBloc(_controller),
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
}
