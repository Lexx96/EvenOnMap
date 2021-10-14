import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/models/news.dart';
import 'package:flutter/material.dart';

class TextBodyWidget extends StatefulWidget {
  final News _newsResponse;
  TextBodyWidget( this._newsResponse,{Key? key}) : super(key: key);

  @override
  _TextBodyWidgetState createState() => _TextBodyWidgetState(_newsResponse);
}

class _TextBodyWidgetState extends State<TextBodyWidget> {
  final News _newsResponse;
  _TextBodyWidgetState(this._newsResponse);
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
    final _maxThreeLines = 3;
    final _maxLines = DefaultTextStyle.of(context).maxLines;
    final Widget _buttonMoreDetails = _maxLinesBool ? TextButton(
      onPressed: () {
        setState(() {
          if (_maxLinesBool) {
            _maxLinesBool = !_maxLinesBool;
          }else {
            _maxLinesBool = true;
          }
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Text(S.of(context).inMoreDetail),
    ) : SizedBox();
    final _resultLines = _maxLinesBool ? _maxThreeLines : _maxLines;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(_newsResponse.email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    // максимальное колличество линий, остальное обрежется
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(child: Text(''),),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _newsResponse.body,
              maxLines: _resultLines,
              overflow: TextOverflow.fade,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buttonMoreDetails,
          ),
          SizedBox(
            height: 20,
          ),
          Image(image: AssetImage('assets/images/mapOne.png')),
        ],
      ),
    );
  }
}