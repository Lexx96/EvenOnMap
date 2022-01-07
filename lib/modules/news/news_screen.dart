import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/modules/main_driwer/main_drawer_screen.dart';
import 'package:event_on_map/modules/news/widgets/end_widget.dart';
import 'package:event_on_map/modules/news/widgets/header_button_widget.dart';
import 'package:event_on_map/modules/news/widgets/image_gallery.dart';
import 'package:event_on_map/modules/news/widgets/sceleton.dart';
import 'package:event_on_map/utils/app_url/app_url.dart';
import 'package:flutter/material.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'models/news.dart';

/// Ключ для сохнанения положения скрола
final bucketGlobal = PageStorageBucket();

/// Экран ленты новостей
class NewsScreen extends StatefulWidget {
  final int? indexEvent;

  NewsScreen([this.indexEvent]);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late final ServiceNewsBloc _bloc;
  late List<GetNewsFromServerModel> _newsFromServer = [];
  late bool _maxLinesBool;
  final int _resultLines = 3;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewsBloc();
    _bloc.loadingNewsFromServer();
    _refreshController = RefreshController();
    _maxLinesBool = true;
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
                  key: PageStorageKey<String>('news screen'),
                  bucket: bucketGlobal,
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _titleText(index),
                                    _descriptionText(_resultLines, index),
                                    _isButton(index),
                                    _bodyImageWidget(index),
                                  ],
                                ),
                              ),
                              EndWidget(_newsFromServer[index]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }

  /// Вывод title в карточке новости, принимает index [index]
  Widget _titleText(index) {
    if (_newsFromServer[index].title.length == 0) {
      return SizedBox.shrink();
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _newsFromServer[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          _newsFromServer[index].title.length == 0
              ? SizedBox.shrink()
              : SizedBox(height: 10),
        ],
      );
    }
  }

  /// Вывод description в карточке новости, принимает количество строк для показа
  /// description int? [_resultLines], index [index]
  Widget _descriptionText(int? _resultLines, index) {
    if (_newsFromServer[index].description.length == 0) {
      return SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 10.0),
        child: Text(
          _newsFromServer[index].description,
          maxLines: _resultLines,
          overflow: TextOverflow.fade,
        ),
      );
    }
  }

  /// Вывод кнопки в карточке новости, принимает index [index]
  Widget _isButton(index) {
    if (_newsFromServer[index].description.length > 147 &&
        _maxLinesBool == true) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: TextButton(
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
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Вывод изображений в ленту новостей, принимает index [index]
  Column _bodyImageWidget(index) {
    final List<String> _images = [];
    final List<String> _allImages = [];
    String _mainImage = '';
    if (_newsFromServer[index].images.length > 0) {
      for (var i = 0; _newsFromServer[index].images.length - 1 >= i; i++) {
        final _image = _newsFromServer[index].images[i].photo;
        _allImages.add(AppUrl.urlNews + _image);
        if (i == 0) {
          _mainImage = AppUrl.urlNews + _image;
        } else {
          _images.add(AppUrl.urlNews + _image);
        }
      }
    }
    Size _mainImageSize = Size(0.0, 0.0);
    _mainImage.isNotEmpty
        ? _calculateImageDimension(_mainImage).then((calculateImage) {
            _mainImageSize = calculateImage;
          })
        : _mainImageSize = Size(0.0, 0.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: InkWell(
            onTap: () => openGallery(0, _allImages),
            splashColor: Colors.transparent,
            child: (_mainImage.isNotEmpty)
                ? CachedNetworkImage(
                    imageUrl: _mainImage,
                    placeholder: (context, url) => Container(
                      color: Colors.grey,
                      height: 320.0,
                      width: _mainImageSize.width,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : SizedBox.shrink(),
          ),
        ),
        const SizedBox(
          height: 3.0,
        ),
        (_images.length > 0)
            ? SizedBox(
                height: 120.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: _images.length,
                  itemBuilder: (BuildContext context, int indexImage) {
                    Size _imageSize = Size(0.0, 0.0);
                    _calculateImageDimension(_images[indexImage])
                        .then((calculateImage) {
                      _imageSize = calculateImage;
                    });
                    return InkWell(
                      onTap: () => openGallery(indexImage + 1, _allImages),
                      splashColor: Colors.transparent,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: _images[indexImage],
                            placeholder: (context, url) => Container(
                              color: Colors.grey,
                              width: _imageSize.width,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          const SizedBox(
                            width: 3.0,
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  /// Открытие виджета показа изображений, принимает index [index]
  /// и массив всех изображений List<String> [_allImages]
  void openGallery(index, List<String> _allImages) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImageGalleryWidget(
          images: _allImages,
          index: index,
        ),
      ),
    );
  }

  /// Метод обновления списка новостей
  void _onRefresh() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      _bloc.onRefresh().then(
        (_) async {
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
      (_) {
        _refreshController.loadComplete();
      },
    );
    _refreshController.loadFailed();
  }

  /// Расчет высоты и ширины изображения, принимает изображение String [_imageForSize]
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
