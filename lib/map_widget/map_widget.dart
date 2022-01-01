import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
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
      _myPositionLatLng = _myLastPosition != null ? _myLastPosition as LatLng : LatLng(53.7444831, 85.0315746);
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
              zoom: 16.0,
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
                      Size _imageSize = Size(0.0, 0.0);
                      _calculateImageDimension('http://23.152.0.13:3000/files/news/' +
                          _dataForCard.images[index].photo).then((calculateImage) {
                        _imageSize = calculateImage;
                      });
                      return InkWell(
                        onTap: () => _openGallery(index, _images),
                        splashColor: Colors.transparent,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: 'http://23.152.0.13:3000/files/news/' + _dataForCard.images[index].photo,
                              placeholder: (context, url) => Container(
                                color: Colors.grey,
                                height: 80.0,
                                width: _imageSize.width,),
                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                child: Row(
                                  children: [
                                    (_dataForCard.user['photo'] != null &&
                                        _dataForCard.user['photo']['photo'] != null)
                                        ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'http://23.152.0.13:3000/files/user/' +
                                            _dataForCard.user['photo']['photo'],
                                      ), //_newsResponse.user.photo.firs
                                      radius: 27,
                                    )
                                        : CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/user.png'),
                                      //_newsResponse.user.photo.firs
                                      radius: 27,
                                    ),
                                    SizedBox(width: 10.0,),
                                    Text(
                                      _dataForCard.user['username'] != null &&
                                          _dataForCard.user['surname'] != null
                                          ? _dataForCard.user['username'] +
                                          ' ' +
                                          _dataForCard.user['surname']
                                          : 'Инкогнито',
                                      style:
                                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
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
                        )
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                            ' 0  ',
                                          ),
                                        ],
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    onTap: () => _showMessage(context),
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
                          Row(
                            children: [
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

  /// Показ уведобления
  void _showMessage (BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
                  '''Лайки находятся в разработке. 
        
И в настоящее время не доступны. \n\nПриносим извинения за неудоства.''',
                )),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('ОК')),
                ],
              ),
            ],
          );
        }
    );
  }

  /// Вывод времени размещения новости
  String _dataTime() {
    var _dataTimeNow = new DateTime.now().toString();
    var _dataTimeFromServer = _dataForCard.createdAt.toString();

    if(_dataTimeFromServer.substring(8,10) == _dataTimeNow.substring(8,10)){
      return 'Сегодня в ' + _dataTimeFromServer.substring(12,16);
    } else {
      return _dataTimeFromServer.substring(8, 10) + // число
          '.' +
          _dataTimeFromServer.substring(5, 7) + // месяц
          '.' +
          _dataTimeFromServer.substring(0, 4) + // год
          ' в ' +
          _dataTimeFromServer.substring(11, 16); // часы и минуты
    }
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
        try{
          _setNewsAddUserPosition.add(_setUserMarker.first);
        }catch(e){
          throw Exception(e);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Расчет высоты и ширины изображения
  Future<Size> _calculateImageDimension(String _imageForSize) {
    Completer<Size> completer = Completer();
    Image image = Image.network(_imageForSize);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }
}
