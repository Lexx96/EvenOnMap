import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/news_page/models/news.dart';
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
  Set<Marker> _setNewsAddUserPosition = {};
  Iterable _setAllNewsMarkers = [];
  late Address _address;

  @override
  void initState() {
    super.initState();
    GoogleMapController _googleMapController;
    _bloc = GoogleMapBloc();
    _bloc.getLatLngAndAddressUserPosition();
    _getNewsFromServer();
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
          return _bodyMapWidget(context, snapshot, _googleMapController);
        },
      ),
    );
  }

  /// Тело страницы
  Scaffold _bodyMapWidget(BuildContext context, AsyncSnapshot snapshot, GoogleMapController googleMapController) {


    // _choiceTheme();  // из за него ошибка

    if (snapshot.data is LoadedAddressFromUserPositionState) {
      final _data = snapshot.data as LoadedAddressFromUserPositionState;
      _myPosition = _data.latLngUserPosition;
      _address = _data.addressUserPosition;
      _getMyMarker(_myPosition, _address);
    } else {
      _address = [] as Address;
      _myPosition = LatLng(0.0, 0.0);
    }

    if (snapshot.data is LoadedLatLngAndAddressFromOnTabState) {
      final _data = snapshot.data as LoadedLatLngAndAddressFromOnTabState;
      final _onTabAddress = _data.onTabAddress;
      final _onTabLatLng = _data.onTabLatLng;
      _onTabMarker(_onTabAddress, _onTabLatLng);
    }

    if (snapshot.data is GetMapThemeState) {
      final _data = snapshot.data as GetMapThemeState;
      final _mapStyle = _data.mapStyle;
      _mapDarkTheme(_mapStyle);
    }

    // if (snapshot.data is AllNewsLoadedState) {
    //   final _data = snapshot.data as AllNewsLoadedState;
    //   final List<GetNewsFromServerModel> newsFromServerModel = _data.newsFromServer;
    //
    //   for (int i = 0; i < newsFromServerModel.length; i++) {
    //     final LatLng latLng = LatLng(newsFromServerModel[i].lat, newsFromServerModel[i].lng);
    //     final String description = newsFromServerModel[i].description;
    //     final String title = newsFromServerModel[i].title;
    //     // _bloc.getAllAddress(latLng).then((addressFrom) =>
    //     //     _allNewsMarkers(address: addressFrom, latLngFromNews: latLng, description: description, title: title)
    //     // );
    //   }
    // }

    return Scaffold(
      body: GoogleMap(
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController googleMapController) {
        _onMapCreated(googleMapController);} ,
        markers: _setNewsAddUserPosition,
        initialCameraPosition: CameraPosition(
          target: _myPosition,
          zoom: 16,
        ),
        onTap: (LatLng _onTabLatLng) => _bloc.getAddressOnTab(_onTabLatLng),
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
  void _onTabMarker(Address _onTabAddress, LatLng _onTabLatLng) async {
    final _onTabMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${_onTabAddress.thoroughfare} ${_onTabAddress.subThoroughfare}',
          // Название
          snippet: 'Создать событие'), // Тело
      position: _onTabLatLng,
    );
    _setOnTabMarkers = MapProvider.refreshSetProvider(
        set: _setOnTabMarkers, marker: _onTabMarker);
  }

  /// Создание маркера из списка новостей
  void _getNewsFromServer() async {
    List<GetNewsFromServerModel> allNews = await _bloc.getAllNews();

    for (int i = 0; i < allNews.length; i++) {
      Address addressFrom =
          await _bloc.getAllAddress(LatLng(allNews[i].lat, allNews[i].lng));

      Iterable _markers = Iterable.generate(
        allNews.length,
        (index) {
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
        _setNewsAddUserPosition.add(_setOnTabMarkers.last); // появляется маркер с запозданием
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
  void _mapDarkTheme(String mapStyle) {
    _googleMapController.setMapStyle(mapStyle);
  }
}
