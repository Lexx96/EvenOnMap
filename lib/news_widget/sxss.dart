import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/bloc/news_bloc.dart';
import 'package:event_on_map/news_widget/services/news_repository.dart';
import 'package:event_on_map/news_widget/widgets/end_widget.dart';
import 'package:event_on_map/news_widget/widgets/header_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/news_state.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsRepository =
        NewsRepository(); // передаем инстанс репозитория т.к. его парпосили в конструкторе NewsBloc. только зачем хз
    return BlocProvider<NewsBloc>(
      // инициализируем bloc используя BlocProvider <NewsBloc>
      create: (context) => NewsBloc(newsRepository: newsRepository),
      child: Scaffold(
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
                                S.of(context).name +
                                    ' ' +
                                    S.of(context).surname,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                            Align(
                              alignment:
                                  Alignment.centerRight + Alignment(0, .3),
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
        body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state is NewsEmptyState) {
            return Center(
              child: Text('Empty State'),
            );
          }
          if (state is NewsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsLoadedState) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.loadedNews.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderButtonWidget(),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.loadedNews[index].email,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            // максимальное колличество линий, остальное обрежется
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(''),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      state.loadedNews[index].body,
                                      maxLines: 3,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                      ),
                                      child: Text('d'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Image(
                                      image: AssetImage(
                                          'assets/images/mapOne.png')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      EndWidget(),
                    ],
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        }),
      ),
    );
  }
}
