import 'dart:async';
import 'dart:io';
import 'package:event_on_map/create_event_map_widget/bloc/create_event_map_bloc.dart';
import 'package:event_on_map/create_event_map_widget/bloc/create_event_map_bloc_state.dart';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/map_widget/service/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../custom_icons_icons.dart';
import 'bloc/pick_image/pick_image_bloc.dart';
import 'bloc/pick_image/pick_image_bloc_state.dart';
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
  LatLng _latLng = LatLng(0.0, 0.0);
  List<Placemark> _placemark = [
    Placemark(street: '', subThoroughfare: ''),
  ];
  List<File?> _listImages = [];

  bool isIsRegistration = false;


  @override
  void initState() {
    super.initState();
    _bloc = CreateEventBloc();
    _bloc.getLatLngAndAddressUserPosition();
    _bloc.isRegistrationFromSharedPreferencesBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen(1,)));
        return false;
      },
      child: Scaffold(
        body: StreamBuilder(
          stream: _bloc.streamEventController,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return _bodyCreateEventWidget(context, snapshot);
          },
        ),
      ),
    );
  }

  /// Тело CreateEventWidget
  Stack _bodyCreateEventWidget(BuildContext context,
      AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.data is GetLatLngAndAddressState) {
      final _data = snapshot.data as GetLatLngAndAddressState;
      _placemark = _data.placemark;
      _latLng =
          LatLng(_data.initialLatLng.latitude, _data.initialLatLng.longitude);
    }

    if (snapshot.data is GetListImagesFromImageWidgetState) {
      GetListImagesFromImageWidgetState _data = snapshot
          .data as GetListImagesFromImageWidgetState;
      _listImages = _data.listImages;
    }

    if (snapshot.data is IsRegistrationUserState) {
      IsRegistrationUserState _data = snapshot.data as IsRegistrationUserState;
       isIsRegistration = _data.isIsRegistration;
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
                    decoration: InputDecoration(
                      hintText: 'Тема',
                    ),
                    controller: _headerTextController,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15.0)),
                  TextField(
                    maxLines: DefaultTextStyle
                        .of(context)
                        .maxLines,
                    minLines: 10,
                    maxLength: 1500,
                    decoration: InputDecoration(
                      hintText: 'Описание',
                    ),
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
            ImagesWidget(bloc: _bloc,),
            _showAddress(context, _placemark),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
              child: TextButton(
                onPressed: () {
                  _bloc.openGoogleMapState();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('На карте'),
                    Icon(
                      CustomIcons.map_marker,
                    ),
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
                      child: Text('Назад'),
                      onPressed: () =>
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => MainScreen(1,)))
                  ),
                  TextButton(
                    child: Text('Создать'),
                    onPressed: () => _postNewEventInServer(_listImages),
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
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            border: Border.all(color: Theme
                .of(context)
                .dividerColor),
            borderRadius: BorderRadius.all(Radius.circular(10),),
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

  /// Показ уведомлений пользователю в AlertDialog
  Widget _showException(AsyncSnapshot snapshot) {
    if (snapshot.data is EventLoadedBlocState) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Новость успешно добавлена!\n \nПосле проверки модератором она будет опубликованна',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        MainScreen(
                          1,),
                  ),
                ),
            child: Text('OK'),
          ),
        ],
      );
    } else if (snapshot.data is PostEvenErrorSendingServerException) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Произошла ошибка \n \nПовторите попытку!',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyCreateEvent(),
            child: Text('OK'),
          ),
        ],
      );
    } else if (snapshot.data is PostEventNotRegisteredSendingServerState) {
      return AlertDialog(
        title: Center(
          child: Text(
            'Ошибка регистрации при добавлении события \n \nПовторите попытку!',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyCreateEvent(),
            child: Text('OK'),
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Размещение нового события на сервер
  void _postNewEventInServer(List<File?> listImages) {
    final _textFromTitle = _headerTextController.text;
    final _textFromDescription = _bodyTextController.text;
    final String lat = _latLng.latitude.toString();
    final String lng = _latLng.longitude.toString();

    if(_headerTextController.text.length < 10 && _bodyTextController.text.length < 10) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  '\n \nТема события и описание не должно быть короче 10 символов',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
      );
    }
    else if(_headerTextController.text.length < 10) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  '\n \nТема события не должна быть короче 10 символов',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
      );
    }
    else if(_bodyTextController.text.length < 10) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  '\n \nОписание события не должно быть короче 10 символов',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
      );
    }
    else if(isIsRegistration == false) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                '\n \nДля размещения события необходмимо указать Имя и Фамилию',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      2,
                    ),
                  ),
                ),
                child: Text('Указать'),
              ),
            ],
          );
        },
      );
    }
    else{
      _bloc.loadingPostEventBloc(
          title: _textFromTitle,
          description: _textFromDescription,
          lng: lng,
          lat: lat,
          listImages: listImages
      );
    }
  }
}


/// Класс с картор для выбора адреса события (нужно будет перенести в отдельный
/// файл, он есть. Не получилось передать LatLng в другой блок)
class CreateEventMapWidget extends StatefulWidget {
  final CreateEventBloc bloc;

  CreateEventMapWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  _CreateEventMapWidgetState createState() => _CreateEventMapWidgetState(bloc);
}

class _CreateEventMapWidgetState extends State<CreateEventMapWidget> {
  CreateEventBloc bloc;

  _CreateEventMapWidgetState(this.bloc);

  late LatLng? _myLastPosition;
  late CreateEventMapBloc _createEventMapBloc;
  Completer<GoogleMapController> _controller = Completer();
  late LatLng _myPosition = LatLng(53.7444831, 85.0315746);
  Set<Marker> _setUserMarkers = {};
  final ButtonStyle buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    minimumSize: MaterialStateProperty.all(Size(45, 45)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
    ),
  );
  final ButtonStyle buttonStyleTwo = ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _createEventMapBloc = CreateEventMapBloc();
    _createEventMapBloc.readMyLastPositionForCreateEventBloc();
    _createEventMapBloc.createEventGetLatLngAndAddressUserPosition();
    MapProvider.onMapCreatedProvider(_controller, null);
  }

  @override
  void dispose() {
    super.dispose();
    _createEventMapBloc.dispose();
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
    MapProvider.choiceMapTheme(_controller);

    LatLng _position = LatLng(0.0, 0.0);
    List<Placemark> _placemark = [Placemark(street: '', subThoroughfare: '')];

    if (snapshot.data is LoadedAddressFromCoordinatesState) {
      final _data = snapshot.data as LoadedAddressFromCoordinatesState;
      _placemark = _data.placemark;
      _position = _data.position;
      _myPosition = LatLng(_position.latitude, _position.longitude);
      _getMyMarker(_myPosition, _placemark);
    }

    if (snapshot.data is ReadMyLastPositionForCreateEventState) {
      final _data = snapshot.data as ReadMyLastPositionForCreateEventState;
      _myLastPosition = _data.myLastPosition;
      _myPosition = (_myLastPosition != null ? _myLastPosition : _myPosition)!;
    }

    return Stack(
      children: [
        GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _setUserMarkers,
            initialCameraPosition: CameraPosition(
              target: _myPosition,
              zoom: 16,
            ),
            onTap: (LatLng _onTabLatLng) =>
                _createEventMapBloc.getAddressOnTab(
                    _onTabLatLng)
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
                    onPressed: () =>
                        MapProvider.onMapCreatedProvider(_controller, null),
                    child: Icon(
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
  Column _showAddress(BuildContext context, List<Placemark> _placemark,
      LatLng _onTabLatLng) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              border: Border.all(color: Theme
                  .of(context)
                  .dividerColor),
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
                        Text('Область/Край'),
                        Text(_placemark.first.administrativeArea == null ? '' : '${_placemark.first.administrativeArea}'),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Город'),
                        Text( _placemark.first.locality == null ? '' : '${_placemark.first.locality}'),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Улица/Проспект'),
                        Text(_placemark.first.street == null ? '' : '${_placemark.first.street}'),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Дом №'),
                        Text(_placemark.first.subThoroughfare == null ? '' : '${_placemark.first.subThoroughfare}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: buttonStyleTwo,
                onPressed: () => bloc.emptyCreateEvent(),
                child: Text('Отмена',),
              ),
              TextButton(
                style: buttonStyleTwo,
                onPressed: () => bloc.getLatLngAndAddressFromMap(_onTabLatLng),
                child: Text('Выбрать',),
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Создание маркера по нажатию на карту для CreateEvent
  void _getMyMarker(LatLng _myPosition, List<Placemark> placemark) async {
    final _userMarker = Marker(
      markerId: MarkerId(''),
      infoWindow: InfoWindow(
          title: '${placemark.first.street} ${placemark.first.subThoroughfare}',
          snippet: 'Выбор адреса для события'), // Тело
      position: _myPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen),
    );
    _setUserMarkers = MapProvider.refreshSetProvider(
        set: _setUserMarkers, marker: _userMarker);
  }
}

/// Класс с выбором изображений для создания события
class ImagesWidget extends StatefulWidget {
  final CreateEventBloc bloc;

  ImagesWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  State<ImagesWidget> createState() => ImagesWidgetState(bloc);
}

class ImagesWidgetState extends State<ImagesWidget> {
  CreateEventBloc bloc;

  ImagesWidgetState(this.bloc);

  final selectedImages = <File?>[];
  late PickImageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PickImageBloc();
    _bloc.notSelectedPickImage();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
      child: SizedBox(
        height: 220,
        child: StreamBuilder(
          stream: _bloc.streamPickImage,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data is LoadedPickImage) {
              LoadedPickImage _data = snapshot.data as LoadedPickImage;
              final _images = _data.image;
              selectedImages.add(_images);
              _bloc.notSelectedPickImage();
              bloc.getListImagesFromImageWidgetBloc(selectedImages);
            }
            return (selectedImages.length == 0)
                ? Row(
              children: [
                _isButton(),
              ],
            )
                : ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    _showImages(context, index, snapshot),
                    SizedBox(
                      width: 10,
                    ),
                    (selectedImages.length <= 6 &&
                        index == selectedImages.length - 1)
                        ? _isButton()
                        : SizedBox.shrink(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }


  /// Карточка вывода изображения
  Container _showImages(BuildContext context, int index,
      AsyncSnapshot<dynamic> snapshot) {
    return Container(
      height: 195,
      width: 90,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        border: Border.all(
            color: Colors.black.withOpacity(0.2)),
        borderRadius:
        BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: Offset(0, 2))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Center(
            child: Image.file(
                selectedImages[index] as File),),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (snapshot.data is LoadedPickImage ||
                      snapshot.data
                      is NotSelectedPickImage)
                      ? Icon(
                    Icons.done,
                    color: Colors.deepOrange,
                    size: 18,
                  )
                      : SizedBox(
                      height: 20,
                      width: 20,
                      child:
                      CircularProgressIndicator()),
                ],
              )
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showActions(context, index),
            ),
          )
        ],
      ),
    );
  }

  /// Выбор источника изображения
  _showCardAdd(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    _bloc.addPickImageBloc(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.camera_alt), Text('Камера')],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    _bloc.addPickImageBloc(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.photo), Text('Галерея')],
                  ),
                ),
              ],
            ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Камера'),
                  onTap: () {
                    _bloc.addPickImageBloc(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Галерея'),
                  onTap: () {
                    _bloc.addPickImageBloc(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );
    }
  }

  /// Действия с выбранным изображением
  _showActions(BuildContext context, index) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.image), Text('Открыть')],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    selectedImages.removeAt(index);
                    _bloc.notSelectedPickImage();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Icon(Icons.delete_outline), Text('Удалить')],
                  ),
                ),
              ],
            ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Открыть'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Удалить'),
                  onTap: () {
                    selectedImages.removeAt(index);
                    _bloc.notSelectedPickImage();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );
    }
  }

  /// Карточка вывода карточки добавить фото
  Widget _isButton() {
    return Container(
      height: 195,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: Offset(0, 2))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: TextButton(
        onPressed: () => _showCardAdd(context),
        child: Icon(
          Icons.add_rounded,
          color: Theme
              .of(context)
              .iconTheme
              .color,
          size: 45,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme
              .of(context)
              .scaffoldBackgroundColor),
        ),
      ),
    );
  }
}



