import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/bloc/news_bloc.dart';
import 'package:event_on_map/news_widget/bloc/news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _resultLines = _maxLinesBool ? maxThreeLines : maxLines;


    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state){
        if(state is NewsEmptyState){
          return Center(child: Text('Empty State'),
          );
        }
        if(state is NewsLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is NewsLoadedState){
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('ddd',
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
                        child: Text('d',
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
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
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
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}