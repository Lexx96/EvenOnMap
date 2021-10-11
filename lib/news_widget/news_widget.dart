import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/bloc/news_bloc.dart';
import 'package:event_on_map/news_widget/services/news_repository.dart';
import 'package:event_on_map/news_widget/widgets/end_widget.dart';
import 'package:event_on_map/news_widget/widgets/header_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../custom_icons.dart';
import 'bloc/news_event.dart';
import 'bloc/news_state.dart';
/*
сделать:
убиралась кнопка подробнее, передести все это дело в блок или инхерит
открывались новости подробнее по индексу и было во весь экран

по нажатию на фото/ видео оно открывалась в проигрователе

сделать кнопку на аву
сделать кнопки лайк и репост




дря работы страницы нужно:

ник нейм
тема поста
тело поста
медиа поста
ссылка на профиль позьзователя
добавление лайков
список всех новостей
 */
class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late bool _maxLinesBool;
  late var _resultLines;

  @override
  void initState() {
    super.initState();
    _maxLinesBool = true;
    _resultLines = 3;
  }

  @override
  Widget build(BuildContext context) {
    final NewsBloc _newsBloc = BlocProvider.of<NewsBloc>(context);
    final maxThreeLines = 3;
    final maxLines = null;
    final String textInTextButton =
    _maxLinesBool ? S.of(context).inMoreDetail : '';
    _resultLines = _maxLinesBool ? maxThreeLines : maxLines;

    final newsRepository = NewsRepository(); // передаем инстанс репозитория т.к. его парпосили в конструкторе NewsBloc. только зачем хз
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
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsEmptyState) {
              _newsBloc.add(NewsLoadEvent());
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
                        Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _newsBloc.add(NewsLoadEvent());
                          },
                          splashColor: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('https://w-dog.ru/wallpapers/3/9/444606473038196/sochi-olimpiada-2014-zima.jpg'),
                                  radius: 27,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.loadedNews[index].email,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '48 ' + S.of(context).minutesAgo,
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {},
                            child: Icon(
                              CustomIcons.location,
                              color: Colors.blue,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              overlayColor: MaterialStateProperty.all(Colors.grey),
                              elevation: MaterialStateProperty.all(0),
                              minimumSize: MaterialStateProperty.all(Size(60,30)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                        Column(
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
                              child: Expanded(
                                child: Text(
                                  state.loadedNews[index].body,
                                  maxLines: _resultLines,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (_maxLinesBool) {
                                      _maxLinesBool = !_maxLinesBool;
                                    } else {
                                      _maxLinesBool = true;
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                ),
                                child: Text(textInTextButton),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image(
                                image: NetworkImage(
                                    'https://w-dog.ru/wallpapers/10/9/463314880930454/ozero-gory-les-zakat-derevya.jpg')),
                          ],
                        ),
                        EndWidget(),
                      ],
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
