
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
  late ServiceNewEventBloc _bloc;

  final _headerTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewEventBloc();
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
          return _bodyCreateEvent(context, snapshot);
        },
      ),
    );
  }

  /// Тело экрана
  Stack _bodyCreateEvent(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    print('1111111111111111111111111111111111111');
    print(snapshot.data);
    List<Placemark> _placemark = [Placemark(street: '', subThoroughfare: ''),];
    LatLng _initialLatLng = LatLng(0.0, 0.00);

    if(snapshot.data is GetLatLngInitialState) {
      final _data = snapshot.data as GetLatLngInitialState;
      _placemark = _data.placemark;
      _initialLatLng = LatLng(_data.initialLatLng.latitude, _data.initialLatLng.longitude);
      _showAddress(context,_placemark);
    }

    LatLng _onTabLatLng = LatLng(0.0, 0.00);
    List<Placemark> _placemarkFromMap = [Placemark(street: '', subThoroughfare: ''),];

    if(snapshot.data is GetLatLngFromMapState ) {
      print('2222222222222222222222222222');
      print(snapshot.data);
      final _data = snapshot.data as GetLatLngFromMapState;
      _placemarkFromMap = _data.placemark;
      LatLng _onTabLatLng = LatLng(_data.onTabLatLng.latitude, _data.onTabLatLng.longitude);
        _showAddress(context,_placemarkFromMap);
    }
    return Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Создать событие',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
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
                      Center(
                        child: Text('Добавить фото')),
                    ],
                  ),
                ),
                ImagesWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Укажите адрес',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(MainNavigationRouteName.createEventMapWidget);
                          },
                          child: Icon(
                            CustomIcons.map_marker,
                            color: Colors.blue,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent),
                            overlayColor:
                            MaterialStateProperty.all(Colors.grey),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize:
                            MaterialStateProperty.all(Size(60, 30)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                _showAddress(context, _placemark),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.grey[100]),
                      ),
                      child: Text('Создать'),
                      onPressed: () => _postNewEventInServer(),
                    ),
                    SizedBox(width: 28),
                  ],
                )
              ],
            ),
            snapshot.data is EventLoadingBlocState
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink(),
            snapshot.data is GetLatLngInitialState ? _showException(snapshot) :  SizedBox.shrink(),
          ],
        );
  }

  /// Вывод адреса события
  Center _showAddress(BuildContext context, List<Placemark> _placemark) {
    return Center(
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
                        ],
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
    final String lat;
    final String lng;
    _bloc.loadingPostEventBloc(
        title: _textFromTitle,
        description: _textFromDescription,
        lng: '5.1',
        lat: '10.1');
  }
}
