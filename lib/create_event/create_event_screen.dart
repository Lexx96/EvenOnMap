import 'package:event_on_map/create_event_map_widget/bloc/create_event_map_bloc.dart';
import 'package:event_on_map/create_event_map_widget/bloc/create_event_map_bloc_state.dart';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'widgets/images_widget.dart';
import 'bloc/create_event/create_event_bloc_state.dart';
import 'bloc/create_event/create_event_bloc.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  late CreateEventBloc _bloc;

  final _headerTextController = TextEditingController();
  final _bodyTextController = TextEditingController();
  final ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.blue)
      ),
    ),
  );
  final BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.black.withOpacity(0.2)),
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [BoxShadow(color: Colors.black)],
  );

  List<Placemark> _placemark = [
    Placemark(street: '', subThoroughfare: ''),
  ];
  LatLng _latLng = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    _bloc = CreateEventBloc();
    _bloc.getLatLngAndAddressUserPosition();
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
        stream: _bloc.streamEventController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _bodyCreateEventWidget(context, snapshot);
        },
      ),
    );
  }

  /// Тело CreateEventWidget
  Stack _bodyCreateEventWidget(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.data is GetLatLngAndAddressState) {
      final _data = snapshot.data as GetLatLngAndAddressState;
      _placemark = _data.placemark;
      _latLng =
          LatLng(_data.initialLatLng.latitude, _data.initialLatLng.longitude);
    }

    return Stack(
      children: [
        ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Создать событие',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    maxLines: 1,
                    maxLength: 50,
                    decoration: _inputDecorationStyle('Заголовок'),
                    controller: _headerTextController,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15.0)),
                  TextField(
                    maxLines: DefaultTextStyle.of(context).maxLines,
                    minLines: 10,
                    maxLength: 1500,
                    decoration: _inputDecorationStyle('Тело события'),
                    controller: _bodyTextController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Divider(height: 1),
                  ),
                  Center(child: Text('Добавить фото')),
                ],
              ),
            ),
            ImagesWidget(),
            _showAddress(context, _placemark),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right:  8.0, top: 10.0),
              child: Container(
                decoration: containerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '  На карте',
                    ),
                    TextButton(
                      onPressed: () {
                        _bloc.openGoogleMapState();
                      },
                      child: Icon(
                        CustomIcons.map_marker,
                        color: Colors.blue,
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.grey),
                        minimumSize: MaterialStateProperty.all(Size(60, 30)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: buttonStyle,
                    child: Text('Создать'),
                    onPressed: () => _postNewEventInServer(),
                  ),
                  TextButton(
                    style: buttonStyle,
                    child: Text('Назад'),
                    onPressed: () => Navigator.of(context).pushNamed(MainNavigationRouteName.mainScreen),
                  ),
                ],
              ),
            )
          ],
        ),
        _showException(snapshot),
        snapshot.data is OpenGoogleMapState
            ? CreateEventMapWidget(
                bloc: _bloc,
              )
            : SizedBox.shrink(),
        snapshot.data is EventLoadingBlocState
            ? Center(child: CircularProgressIndicator())
            : SizedBox.shrink(),
      ],
    );
  }

  /// Вывод адреса события
  Padding _showAddress(BuildContext context, List<Placemark> _placemark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: Container(
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: containerDecoration,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Стиль декорации для TextField
  InputDecoration _inputDecorationStyle(String _hintText) {
    return InputDecoration(
      enabled: true,
      fillColor: Colors.grey[200],
      filled: true,
      hintText: _hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.0,
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 2.0,
          color: Colors.blue,
        ),
      ),
    );
  }

  /// Показ уведомлений пользователю в AlertDialog
  Widget _showException(AsyncSnapshot snapshot) {
    if (snapshot.data is EventLoadedBlocState) {
      return AlertDialog(
        title: Center(
            child: Text(
          'Новость успешно добавлена!\n \nПосле проверки модератором она будет опубликованна',
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    } else if (snapshot.data is PostEvenErrorSendingServerException) {
      return AlertDialog(
        title: Center(
            child: Text(
          'Произошла ошибка \n \nПовторите попытку!',
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    } else if (snapshot.data is PostEventNotRegisteredSendingServerState) {
      return AlertDialog(
        title: Center(
            child: Text(
          'Ошибка регистрации при добавлении события \n \nПовторите попытку!',
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Размещение нового события на сервер
  void _postNewEventInServer() {
    final _textFromTitle = _headerTextController.text;
    final _textFromDescription = _bodyTextController.text;
    final String lat = _latLng.latitude.toString();
    final String lng = _latLng.longitude.toString();
    _bloc.loadingPostEventBloc(
        title: _textFromTitle,
        description: _textFromDescription,
        lng: lng,
        lat: lat);
  }
}







/// Класс с картор для выбора адреса события (нужно будет перенести в отдельный
/// файл, он есть. Не получилось передать LatLng в другой блок)
class CreateEventMapWidget extends StatefulWidget {
  CreateEventBloc bloc;

  CreateEventMapWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  _CreateEventMapWidgetState createState() => _CreateEventMapWidgetState(bloc);
}

class _CreateEventMapWidgetState extends State<CreateEventMapWidget> {
  CreateEventBloc bloc;

  _CreateEventMapWidgetState(this.bloc);

  late CreateEventMapBloc _createEventMapBloc;
  late GoogleMapController _googleMapController;
  late LatLng _myPosition = LatLng(0.0, 0.0);
  Set<Marker> _setUserMarkers = {};
  final ButtonStyle buttonStyle = ButtonStyle(
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
  final ButtonStyle buttonStyleTwo = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.blue)
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _createEventMapBloc = CreateEventMapBloc();
    _createEventMapBloc.createEventGetLatLngAndAddressUserPosition();
    GoogleMapController _googleMapController;
  }

  @override
  void dispose() {
    super.dispose();
    _createEventMapBloc.dispose();
    _googleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _createEventMapBloc.streamCreateEventMapController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _body(snapshot, context);
        },
      ),
    );
  }

  /// Тело CreateEventMapWidget
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
            onTap: (LatLng _onTabLatLng) => _createEventMapBloc.getAddressOnTab(
                _onTabLatLng) // получение LatLng по нажатию на карту
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
                    onPressed: () => _createEventMapBloc
                        .createEventGetLatLngAndAddressUserPosition(),
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
  Column _showAddress(BuildContext context, List<Placemark> _placemark, LatLng _onTabLatLng) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [BoxShadow(color: Colors.black)],
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Область/Край', style: TextStyle(color: Colors.black),),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: buttonStyleTwo,
                onPressed: () {
                  bloc.getLatLngAndAddressFromMap(_onTabLatLng);
                },
                child: Text('Выбрать'),
              ),
            ),
          ],
        )
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
