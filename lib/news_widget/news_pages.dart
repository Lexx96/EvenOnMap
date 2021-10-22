
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

/*
сделать:
по нажатию на фото/ видео оно открывалась в проигрователе

сделать кнопки лайк и репост

*/

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState(NewsRepository());
}

class _NewsWidgetState extends State<NewsWidget> {
  _NewsWidgetState(this._newsRepository);

  late final ServiceNewsBloc _bloc;
  late final NewsRepository _newsRepository;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewsBloc(_newsRepository);
    _bloc.loading();
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
          if (snapshot.data is NewsEmptyState) {
            return SkeletonWidget();
          }
          if (snapshot.data is NewsLoadingState) {
            return SkeletonWidget();
          }
          if (snapshot.data is NewsLoadedState) {
            var newsResponse = snapshot.data as NewsLoadedState;
            return
              ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: newsResponse.news.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.symmetric(vertical : BorderSide.none,)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeaderButtonWidget(),
                      TextBodyWidget(newsResponse.news[index]),
                      const EndWidget(),
                    ],
                  ),
                );
              },
            );
          }
          return SkeletonWidget();
        },
      ),
    );
  }
}
