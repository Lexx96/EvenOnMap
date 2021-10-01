import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/news_widget/services/news_repository.dart';
import 'package:flutter/material.dart';

class TextBodyWidget extends StatefulWidget {
  TextBodyWidget({Key? key}) : super(key: key);

  @override
  _TextBodyWidgetState createState() => _TextBodyWidgetState();
}

class _TextBodyWidgetState extends State<TextBodyWidget> {
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
    final String textInTextButton = _maxLinesBool ? S.of(context).inMoreDetail : '';
    final String infoWidget =
        'Блок камер нового iPhone 13, цены на который в России начинаются '
        'от 80 тыс. рублей, вызвал немало споров ещё на этапе "разогрева" '
        'аудитории через блогеров. За пару месяцев до презентации 14 сентября '
        'Apple разослала им сэмплы новых телефонов, и дизайн с разнесённым по '
        'диагонали блоком камер взбесил постоянных клиентов Apple и фанатов '
        'iPhone.';
    _resultLines = _maxLinesBool ? maxThreeLines : maxLines;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(infoWidget,
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
              infoWidget,
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
                  }else {
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
    );
  }
}