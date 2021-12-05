import 'dart:async';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:event_on_map/news_page/widgets/image_gallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  late GetNewsFromServerModel _news;
  late GoogleMapBloc _bloc;
  late LatLng? _myLastPosition;
  late LatLng _myPositionLatLng = LatLng(53.7444831, 85.0315746);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _setUserMarker = {};
  Set<Marker> _setNewsAddUserPosition = {};

  final List<String> images = [
    'https://im0-tub-ru.yandex.net/i?id=16d9e6eddcbdfdeba9de432422bca25e-l&n=13',
    'https://get.wallhere.com/photo/2560x1600-px-clear-sky-forest-landscape-pine-trees-road-sky-summer-1413157.jpg',
    'https://w-dog.ru/wallpapers/9/17/322057789001671/zakat-nebo-solnce-luchi-oblaka-tuchi-pole-kolosya-zelenye-trava.jpg',
    'https://im0-tub-ru.yandex.net/i?id=16d9e6eddcbdfdeba9de432422bca25e-l&n=13',
    'https://get.wallhere.com/photo/2560x1600-px-clear-sky-forest-landscape-pine-trees-road-sky-summer-1413157.jpg',
    'https://w-dog.ru/wallpapers/9/17/322057789001671/zakat-nebo-solnce-luchi-oblaka-tuchi-pole-kolosya-zelenye-trava.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _bloc = GoogleMapBloc();
    _bloc.readMyLastPositionBloc();
    _bloc.getAllNewsFromServerBloc();
    _bloc.getLatLngAndAddressUserPositionBloc(_controller, latLngNews);
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

    if (snapshot.data is LoadedAddressFromUserPositionState) {
      final _data = snapshot.data as LoadedAddressFromUserPositionState;
      _setUserMarker.add(_data.setUserMarker.first);
    }

    if (snapshot.data is GetAllNewsFromServerState) {
      final _data = snapshot.data as GetAllNewsFromServerState;
      Set<Marker> _newsMarkers = _data.markers;
      _newsMarkers.add(_setUserMarker.first);
      _setNewsAddUserPosition = _newsMarkers;
    }

    // происходит запрос к _myPositionLatLng быстрее чем ей присваевается значение, ошибка позней инициализации
    if (snapshot.data is ReadMyLastPositionState) {
      final _data = snapshot.data as ReadMyLastPositionState;
      _myLastPosition = _data.myLastPosition;
      _myPositionLatLng = _myLastPosition ?? _myLastPosition as LatLng;
    }

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
            onTap: (LatLng latLng) {print('from map' + latLng.toString());},
          ),
          cardForMarker(title: '', showCard: true)
        ],
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
              SizedBox(height: 10.0,),
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
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         TextButton(
          //           onPressed: () => Navigator.of(context)
          //               .pushNamedAndRemoveUntil(
          //                   MainNavigationRouteName.createAnEventWidget,
          //                   (route) => false),
          //           child: Text(
          //             'Создать событие',
          //             style: TextStyle(fontSize: 18),
          //           ),
          //           style: ButtonStyle(
          //             shape: MaterialStateProperty.all(
          //               RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget cardForMarker({required String title, required bool showCard}) {
    var a ='';
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
                SizedBox(
                  height: 60.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => _openGallery(index),
                        splashColor: Colors.transparent,
                        child: Row(
                          children: [
                            Image(
                              image: NetworkImage(images[index]),
                            ),
                            SizedBox(
                              width: 1.0,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ул. Кирова д.55',
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
                                      onTap: () {},
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(title.isNotEmpty ? title : '',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Сегодня 14:35',
                                style: TextStyle(
                                  fontSize: 12.0,
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
                              'Тело события Тело события Тело события Тело события Тело события Тело события Тело события Тело события Тело событияТело событияТело событиямТело событияТело событияТело событияТело событияТело событияТело события',
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
                            onPressed: () => Share.share('text'),
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text('К новости'),
                                ),
                              ],
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

  // /// Вывод title
  // Widget _titleText(index) {
  //   if (_newsFromServer[index].title.length == 0) {
  //     return SizedBox.shrink();
  //   } else {
  //     return Text(
  //       _newsFromServer[index].title,
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //       ),
  //       maxLines: 1,
  //       overflow: TextOverflow.ellipsis,
  //     );
  //   }
  // }

  /// Открытие виджета показа изображений
  void _openGallery(index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryWidget(
          images: images,
          index: index,
        ),
      ),
    );
  }
}

class CardInfoWidget extends StatefulWidget {
  final String title;
  CardInfoWidget(this.title);

  @override
  _CardInfoWidgetState createState() => _CardInfoWidgetState();
}

class _CardInfoWidgetState extends State<CardInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title)
    );
    // return Padding(
    //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Theme.of(context).scaffoldBackgroundColor,
    //           borderRadius: BorderRadius.all(Radius.circular(10)),
    //         ),
    //         child: Column(
    //           children: [
    //             SizedBox(
    //               height: 60.0,
    //               child: ListView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 physics: BouncingScrollPhysics(),
    //                 itemCount: images.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return InkWell(
    //                     onTap: () => _openGallery(index),
    //                     splashColor: Colors.transparent,
    //                     child: Row(
    //                       children: [
    //                         Image(
    //                           image: NetworkImage(images[index]),
    //                         ),
    //                         SizedBox(
    //                           width: 1.0,
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 8.0),
    //               child: Column(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(left: 8.0, top: 8.0),
    //                     child: Expanded(
    //                       child: Row(
    //                         children: [
    //                           Expanded(
    //                             child: Text(
    //                               'ул. Кирова д.55',
    //                               style: TextStyle(
    //                                   fontSize: 16.0,
    //                                   fontWeight: FontWeight.bold),
    //                               maxLines: 1,
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(right: 8.0),
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 color: Colors.grey[300],
    //                                 borderRadius:
    //                                 BorderRadius.all(Radius.circular(60)),
    //                               ),
    //                               child: Material(
    //                                 color: Colors.transparent,
    //                                 child: InkWell(
    //                                   onTap: () {},
    //                                   child: Icon(
    //                                     Icons.clear,
    //                                     size: 30.0,
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ),
    //                               clipBehavior: Clip.hardEdge,
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    //                     child: Row(
    //                       children: [
    //                         Expanded(
    //                           child: Text(title,
    //                             style: TextStyle(
    //                               fontSize: 16.0,
    //                             ),
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(right: 8.0),
    //                           child: Text(
    //                             'Сегодня 14:35',
    //                             style: TextStyle(
    //                               fontSize: 12.0,
    //                             ),
    //                             maxLines: 1,
    //                             overflow: TextOverflow.ellipsis,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                         child: Text(
    //                           'Тело события Тело события Тело события Тело события Тело события Тело события Тело события Тело события Тело событияТело событияТело событиямТело событияТело событияТело событияТело событияТело событияТело события',
    //                           style: TextStyle(fontSize: 14.0),
    //                           maxLines: 3,
    //                           overflow: TextOverflow.fade,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Material(
    //                           color: Colors.transparent,
    //                           child: InkWell(
    //                             child: Container(
    //                               height: 30,
    //                               decoration: BoxDecoration(
    //                                 color: Colors.transparent,
    //                                 borderRadius:
    //                                 BorderRadius.all(Radius.circular(25)),
    //                               ),
    //                               child: Row(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: [
    //                                   Padding(
    //                                     padding:
    //                                     const EdgeInsets.only(left: 10),
    //                                     child: Icon(
    //                                       CustomIcons.heart_1,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     ' 25  ',
    //                                   ),
    //                                 ],
    //                               ),
    //                               clipBehavior: Clip.hardEdge,
    //                             ),
    //                             onTap: () {},
    //                             borderRadius:
    //                             BorderRadius.all(Radius.circular(25)),
    //                             splashColor: Theme.of(context).splashColor,
    //                           ),
    //                         ),
    //                       ),
    //                       TextButton(
    //                         onPressed: () => Share.share('text'),
    //                         //https://www.youtube.com/watch?v=-PmUFbbA-Fs
    //                         child: Icon(
    //                           Icons.share,
    //                           color: Theme.of(context).iconTheme.color,
    //                         ),
    //                         style: ButtonStyle(
    //                           backgroundColor:
    //                           MaterialStateProperty.all(Colors.transparent),
    //                           elevation: MaterialStateProperty.all(0),
    //                           padding:
    //                           MaterialStateProperty.all(EdgeInsets.zero),
    //                           minimumSize:
    //                           MaterialStateProperty.all(Size(60, 30)),
    //                           shape: MaterialStateProperty.all(
    //                             RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(25),
    //                                 side:
    //                                 BorderSide(color: Colors.transparent)),
    //                           ),
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             TextButton(
    //                               onPressed: () {},
    //                               child: Text('К новости'),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //         clipBehavior: Clip.hardEdge,
    //       ),
    //     ],
    //   ),
    // );
  }
}
