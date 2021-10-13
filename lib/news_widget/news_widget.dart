import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/bloc/news_bloc.dart';
import 'package:event_on_map/news_widget/services/news_api_repository.dart';
import 'package:event_on_map/news_widget/widgets/end_widget.dart';
import 'package:event_on_map/news_widget/widgets/header_button_widget.dart';
import 'package:event_on_map/news_widget/widgets/sceleton.dart';
import 'package:event_on_map/news_widget/widgets/text_body_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bloc/news_state.dart';

/*
сделать:
убиралась кнопка подробнее, передести все это дело в блок или инхерит

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
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 180,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              S.of(context).name + ' ' + S.of(context).surname,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight + Alignment(0, .3),
                            child: Text(S.of(context).mail,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(S.of(context).profile),
            onTap: () {
              Navigator.of(context).pushNamed('');
            },
          ),
          ListTile(
            title: Text(S.of(context).registration),
            onTap: () {
              Navigator.of(context).pushNamed('/InPut');
            },
          ),
          ListTile(
            title: Text(S.of(context).aboutTheApp),
            onTap: () {
              Navigator.of(context).pushNamed('/InPut');
            },
          ),
        ],
      )),
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
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: newsResponse.news.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black.withOpacity(0.9))),
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
