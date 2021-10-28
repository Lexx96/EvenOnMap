import 'package:event_on_map/news_widget/bloc/news_bloc.dart';
import 'package:event_on_map/news_widget/services/news_api_repository.dart';
import 'package:event_on_map/news_widget/widgets/end_widget.dart';
import 'package:event_on_map/news_widget/widgets/header_button_widget.dart';
import 'package:event_on_map/news_widget/widgets/sceleton.dart';
import 'package:event_on_map/news_widget/widgets/text_body_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_drawer.dart';
import 'bloc/news_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
сделать:
по нажатию на фото/ видео оно открывалась в проигрователе
сделать кнопки лайк и репост
*/

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState(NewsRepository());
}

class _NewsPageState extends State<NewsPage> {
  _NewsPageState(this._newsRepository);

  late final ServiceNewsBloc _bloc;
  late final NewsRepository _newsRepository;

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      _bloc.onRefresh().then((value) async {
        _refreshController.refreshCompleted();
      });
    } catch (errorOnRefresh) {
      print('Ошибка обновления страницы $errorOnRefresh');
      _refreshController.loadFailed();
    }
    // сделать что бы циркуляр крутился продолжалась до момента окончания загрузки
  }

  Future<void> _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _bloc.onLoading().then((value) {
      _refreshController.loadComplete();
    });
    _refreshController.loadFailed();
  }

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewsBloc(_newsRepository);
    _bloc.loading();
    _refreshController = RefreshController();
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
          print('1111111111111111111111111111111111111111');
          print(snapshot.data);

          if(snapshot.data is NewsLoadingState ) {
            return SkeletonWidget();
          }
          if (snapshot.data is NewsLoadedState||
              snapshot.data is NewsEmptyState) {
            print(snapshot.data);
              var newsResponseData = snapshot.data as NewsLoadedState;
            return  SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus? mode) {
                        if (mode == LoadStatus.idle) {
                          Text("pull up load");
                        } else if (mode == LoadStatus.loading) {
                          CircularProgressIndicator();
                        } else if (mode == LoadStatus.failed) {
                          Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          Text("release to load more");
                        } else {
                          Text("No more Data");
                        }
                        return Container();
                      },
                    ),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: newsResponseData.newsFromServer.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(

                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.symmetric(
                                vertical: BorderSide.none,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const HeaderButtonWidget(),
                              TextBodyWidget(newsResponseData.newsFromServer[index]),
                              const EndWidget(),
                            ],
                          ),
                        );
                      },
                    ));
          }
          return SkeletonWidget();
        },
      ),
    );
  }
}
