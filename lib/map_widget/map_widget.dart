import 'dart:async';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:event_on_map/news_page/services/news_provider.dart';
import 'package:event_on_map/news_page/widgets/image_gallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../custom_icons_icons.dart';
import 'bloc/map_bloc.dart';
import 'bloc/map_bloc_state.dart';
import 'service/map_provider.dart';

class MapWidget extends StatefulWidget {
  final LatLng? latLngNews;

  MapWidget([this.latLngNews]);

  @override
  MapWidgetState createState() => MapWidgetState(latLngNews);
}

class MapWidgetState extends State<MapWidget> {
  late LatLng? latLngNews;
  MapWidgetState(this.latLngNews);
  late GoogleMapBloc _bloc;
  late LatLng? _myLastPosition;
  late LatLng _myPositionLatLng = LatLng(53.7444831, 85.0315746);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _setUserMarker = {};
  Set<Marker> _setNewsAddUserPosition = {};
  late GetNewsFromServerModel _dataForCard;
  late String? _addressForCard;


  @override
  void initState() {
    super.initState();
    _bloc = GoogleMapBloc();
    _bloc.readMyLastPositionBloc();
    _bloc.getLatLngAndAddressAndMarkerUserPositionBloc(_controller, latLngNews);
    _getAllNewsFromServerProvider();
    // _bloc.getAllNewsFromServerBloc();
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
    MapProvider.choiceMapTheme(_controller);

    // происходит запрос к _myPositionLatLng быстрее чем ей присваевается значение, ошибка позней инициализации
    if (snapshot.data is ReadMyLastPositionState) {
      final _data = snapshot.data as ReadMyLastPositionState;
      _myLastPosition = _data.myLastPosition;
      _myPositionLatLng = _myLastPosition ?? _myLastPosition as LatLng;
    }

    if (snapshot.data is LoadedAddressFromUserPositionState) {
      final _data = snapshot.data as LoadedAddressFromUserPositionState;
      _setUserMarker.add(_data.setUserMarker.first);
    }

    if (snapshot.data is CardForMarkerState) {
      final _data = snapshot.data as CardForMarkerState;
      _dataForCard = _data.dataForCard;
      _addressForCard = _data.address;
    }

    // /// Логика рабочая. Но нет возможности по onTab вывести карточку события на экран
    // if (snapshot.data is GetAllNewsFromServerState) {
    //   final _data = snapshot.data as GetAllNewsFromServerState;
    //   Set<Marker> _newsMarkers = _data.markers;
    //   _newsMarkers.add(_setUserMarker.first);
    //   _setNewsAddUserPosition = _newsMarkers;
    // }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              await MapProvider.onMapCreatedProvider(_controller, latLngNews);
            },
            markers: _setNewsAddUserPosition,
            initialCameraPosition: CameraPosition(
              target: _myPositionLatLng,
              zoom: 16,
            ),
            onTap: (LatLng latLng) => _bloc.emptyBloc(),
          ),
          snapshot.data is CardForMarkerState
              ? cardForMarker()
              : SizedBox.shrink()
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            MainNavigationRouteName.createAnEventWidget,
                            (route) => false),
                    child: Icon(
                      Icons.add_location_alt_outlined,
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
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _bloc.emptyBloc();
                      _bloc.getLatLngAndAddressAndMarkerUserPositionBloc(
                          _controller);
                    },
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
        ],
      ),
    );
  }

  /// Виджет вывода информации маркера в виджете на карте
  Widget cardForMarker() {
    final List<String> _images = [];
    if (_dataForCard.images.length > 0) {
      for (var i = 0; i < _dataForCard.images.length; i++) {
        _images.add('http://23.152.0.13:3000/files/news/' +
            _dataForCard.images[i].photo);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                _dataForCard.images.length > 0 ? SizedBox(
                  height: 80.0,
                  child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: _dataForCard.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => _openGallery(index, _images),
                        splashColor: Colors.transparent,
                        child: Row(
                          children: [
                            Image(
                              image: NetworkImage(
                                  'http://23.152.0.13:3000/files/news/' +
                                      _dataForCard.images[index].photo),
                            ),
                            SizedBox(
                              width: 1.0,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ) : SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _addressForCard != null
                                    ? _addressForCard as String
                                    : 'Адрес не определен',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _bloc.emptyBloc(),
                                    child: Icon(
                                      Icons.clear,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _dataForCard.title,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(_dataTime(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _dataForCard.description,
                              style: TextStyle(fontSize: 14.0),
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          CustomIcons.heart_1,
                                        ),
                                      ),
                                      Text(
                                        ' 25  ',
                                      ),
                                    ],
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onTap: () {},
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                splashColor: Theme.of(context).splashColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Share.share(_dataForCard.id),
                            //https://www.youtube.com/watch?v=-PmUFbbA-Fs
                            child: Icon(
                              Icons.share,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              minimumSize:
                                  MaterialStateProperty.all(Size(60, 30)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side:
                                        BorderSide(color: Colors.transparent)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            clipBehavior: Clip.hardEdge,
          ),
        ],
      ),
    );
  }

  /// Вывод времени размещения новости
  String _dataTime() {
    var _dataTimeNow = new DateTime.now().toString();
    var _dataTimeFromServer = _dataForCard.user['createdAt'].toString();

    if(_dataTimeFromServer.substring(8,10) == _dataTimeNow.substring(8,10)){
      return 'Сегодня в ' + _dataTimeFromServer.substring(12,16);
    } else if(_dataForCard.user['createdAt'] != null) {
      return _dataTimeFromServer.substring(8,10)
            + '.' + _dataTimeFromServer.substring(5,7)
            + '.' + _dataTimeFromServer.substring(0,4)
            + ' в ' + _dataTimeFromServer.substring(12,16);
    }
    return'Время размещения неопределенно';
  }

  /// Открытие виджета показа изображений
  void _openGallery(index, _images) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryWidget(
          images: _images,
          index: index,
        ),
      ),
    );
  }

  /// Возвращает адрес для маркера новостей
  static String? _titleForMarker(Address thisAddress) {
    String? title;
    if (thisAddress.thoroughfare != null &&
        thisAddress.subThoroughfare != null) {
      return title =
          '${thisAddress.thoroughfare} ${thisAddress.subThoroughfare}';
    } else {
      return title = '${thisAddress.addressLine}';
    }
  }

  /// Получение новостей с сервера и создание маркеров новостей
  Future<void> _getAllNewsFromServerProvider() async {
    List<GetNewsFromServerModel> listAllNews =
        await NewsProvider().getAllNewsFromServer();
    try {
      for (int i = 0; i < listAllNews.length; i++) {
        if (listAllNews.asMap().containsKey(i)) {
          Address thisAddress = await MapProvider.getAddressFromCoordinates(
              LatLng(listAllNews[i].lat, listAllNews[i].lng));
          Marker _marker = Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              markerId: MarkerId('${listAllNews[i].id}'),
              infoWindow: InfoWindow(
                title: _titleForMarker(thisAddress),
                snippet: '          ',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MainScreen(
                          0, null, i),
                    ),
                  );
                }
              ),
              position: LatLng(listAllNews[i].lat, listAllNews[i].lng),
              onTap: () => _bloc.cardForMarkerBloc(
                  listAllNews[i], _titleForMarker(thisAddress)));
          _setNewsAddUserPosition.add(_marker);
        }
      }
      setState(() {
        _setNewsAddUserPosition.add(_setUserMarker.first);
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
