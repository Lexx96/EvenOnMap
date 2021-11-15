import 'package:event_on_map/news_page/services/news_api_repository.dart';
import 'package:event_on_map/news_page/widgets/end_widget.dart';
import 'package:event_on_map/news_page/widgets/header_button_widget.dart';
import 'package:event_on_map/news_page/widgets/sceleton.dart';
import 'package:event_on_map/news_page/widgets/text_body_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main_driwer/main_drawer.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewsBloc(_newsRepository);
    _bloc.loadingNewsFromServer();
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
          if (snapshot.data is NewsLoadingState) {
            return SkeletonWidget();
          }
          NewsLoadedState newsResponseData = snapshot.data as NewsLoadedState;
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: newsResponseData.newsFromServer.length,
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
                      const HeaderButtonWidget(),
                      TextBodyWidget(newsResponseData.newsFromServer[index]),
                      const EndWidget(),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
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
