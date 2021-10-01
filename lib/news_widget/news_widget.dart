import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/bloc/news_bloc.dart';
import 'package:event_on_map/news_widget/bloc/news_state.dart';
import 'package:event_on_map/news_widget/services/news_repository.dart';
import 'package:event_on_map/news_widget/widgets/end_widget.dart';
import 'package:event_on_map/news_widget/widgets/header_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsRepository =
        NewsRepository(); // передаем инстанс репозитория т.к. его парпосили в конструкторе NewsBloc. только зачем хз
    return BlocProvider<NewsBloc>(
      // инициализируем bloc используя BlocProvider <NewsBloc>
      create: (context) => NewsBloc(newsRepository: newsRepository),
      // create принимает context
      child: Scaffold(
        // в  child передаем
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
        body: NewsList(),
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  const NewsList({
    Key? key,
  }) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  late bool _maxLinesBool;
  late var _resultLines;

  // final _newsRepository = NewsRepository();
  @override
  void initState() {
    super.initState();
    _maxLinesBool = true;
    _resultLines = 3;
  }

  @override
  Widget build(BuildContext context) {
    final maxThreeLines = 3;
    final maxLines = DefaultTextStyle.of(context).maxLines;
    final String textInTextButton =
        _maxLinesBool ? S.of(context).inMoreDetail : '';
    // final String infoWidget =
    //     'Блок камер нового iPhone 13, цены на который в России начинаются '
    //     'от 80 тыс. рублей, вызвал немало споров ещё на этапе "разогрева" '
    //     'аудитории через блогеров. За пару месяцев до презентации 14 сентября '
    //     'Apple разослала им сэмплы новых телефонов, и дизайн с разнесённым по '
    //     'диагонали блоком камер взбесил постоянных клиентов Apple и фанатов '
    //     'iPhone.';
    _resultLines = _maxLinesBool ? maxThreeLines : maxLines;

    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        // принимает новые состояния которые прописали
        if (state is NewsEmptyState) {
          return Center(
            child: Text('Error load. Try again'),
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
            itemCount: state.loadedNews.length, // указываем длинну списка
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderButtonWidget(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.loadedNews[index].name,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              state.loadedNews[index].body,
                              maxLines: _resultLines,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              child: Text(textInTextButton),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image(image: AssetImage('assets/images/mapOne.png')),
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
      },
    );
  }
}
