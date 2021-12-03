import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_page/services/news_api_repository.dart';
import 'package:event_on_map/news_page/widgets/end_widget.dart';
import 'package:event_on_map/news_page/widgets/header_button_widget.dart';
import 'package:event_on_map/news_page/widgets/image_gallery.dart';
import 'package:event_on_map/news_page/widgets/sceleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_driwer/main_drawer.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'models/news.dart';

final bucketGlobal = PageStorageBucket();

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState(NewsRepository());
}

class _NewsPageState extends State<NewsPage> {
  _NewsPageState(this._newsRepository);

  late final ServiceNewsBloc _bloc;
  late final NewsRepository _newsRepository;
  late List<GetNewsFromServerModel> _newsFromServer = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  late bool _maxLinesBool;
  late int _resultLines;

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
    _bloc = ServiceNewsBloc(_newsRepository);
    _bloc.loadingNewsFromServer();
    _refreshController = RefreshController();

    _maxLinesBool = true;
    _resultLines = 3;
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: StreamBuilder(
        stream: _bloc.newsStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is NewsLoadedState) {
            final _data = snapshot.data as NewsLoadedState;
            _newsFromServer = _data.newsFromServer;
          }

          return snapshot.data is NewsLoadingState
              ? SkeletonWidget()
              : PageStorage(
                  bucket: bucketGlobal,
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      key: PageStorageKey<String>('news screen'),
                      physics: BouncingScrollPhysics(),
                      itemCount: _newsFromServer.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide.none,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeaderButtonWidget(_newsFromServer[index]),
                              Container(
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: _titleText(index),
                                              ),
                                              Expanded(child: Text('')),
                                            ],
                                          ),
                                        ),
                                        _newsFromServer[index].title.length == 0
                                            ? SizedBox.shrink()
                                            : SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: _descriptionText(
                                              _resultLines, index),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              bottom: 10.0),
                                          child: _isButton(index),
                                        ),
                                      ],
                                    ),
                                    bodyImageWidget(),
                                  ],
                                ),
                              ),
                              EndWidget(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  /// Вывод изображений
  Column bodyImageWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: InkWell(
            onTap: () => openGallery(0),
            splashColor: Colors.transparent,
            child: Image(
              image: NetworkImage(images[0]),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 150.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => openGallery(index),
                splashColor: Colors.transparent,
                child: Row(
                  children: [
                    Image(
                      image: NetworkImage(images[index]),
                    ),
                    SizedBox(
                      width: 5.0,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Открытие виджета показа изображений
  void openGallery(index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryWidget(
          images: images,
          index: index,
        ),
      ),
    );
  }

  /// Вывод title
  Widget _titleText(index) {
    if (_newsFromServer[index].title.length == 0) {
      return SizedBox.shrink();
    } else {
      return Text(
        _newsFromServer[index].title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  /// Вывод description
  Widget _descriptionText(int? _resultLines, index) {
    if (_newsFromServer[index].description.length == 0) {
      return SizedBox.shrink();
    } else {
      return Text(
        _newsFromServer[index].description,
        maxLines: _resultLines,
        overflow: TextOverflow.fade,
      );
    }
  }

  /// Вывод кнопки "Подробнее ..."
  Widget _isButton(index) {
    if (_newsFromServer[index].description.length > 147 &&
        _maxLinesBool == true) {
      return TextButton(
        onPressed: () {
          setState(
            () {
              if (_maxLinesBool) {
                _maxLinesBool = !_maxLinesBool;
              } else {
                _maxLinesBool = true;
              }
            },
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(50, 30)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(Colors.grey),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Text(S.of(context).inMoreDetail),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Метод обновления списка новостей
  void _onRefresh() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      _bloc.onRefresh().then(
        (value) async {
          _refreshController.refreshCompleted();
        },
      );
    } catch (errorOnRefresh) {
      print('Ошибка обновления страницы $errorOnRefresh');
      _refreshController.loadFailed();
    }
  }

  /// Метод загрузки новых новостей
  Future<void> _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _bloc.onLoading().then(
      (value) {
        _refreshController.loadComplete();
      },
    );
    _refreshController.loadFailed();
  }
}
