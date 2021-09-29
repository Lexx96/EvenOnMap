import 'package:event_on_map/custom_icons.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

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
                                child: Text(S.of(context).name + ' ' + S.of(context).surname,
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
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderButtonWidget(),
                  TextBodyWidget(),
                  EndWidget(),
                ],
              ),
            );
        },
      ),
    );
  }
}

class HeaderButtonWidget extends StatelessWidget {
  const HeaderButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => print('cc'),
          splashColor: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/mapOne.png'),
                  radius: 27,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).userNickname,
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
    );
  }
}

class TextBodyWidget extends StatefulWidget {
  const TextBodyWidget({Key? key}) : super(key: key);

  @override
  _TextBodyWidgetState createState() => _TextBodyWidgetState();
}

class _TextBodyWidgetState extends State<TextBodyWidget> {
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
    final maxFreeLines = 3;
    final maxLines = DefaultTextStyle.of(context).maxLines;
    final String textInTextButton = _maxLinesBool ? S.of(context).inMoreDetail : '';
    final String infoWidget =
        'Блок камер нового iPhone 13, цены на который в России начинаются '
        'от 80 тыс. рублей, вызвал немало споров ещё на этапе "разогрева" '
        'аудитории через блогеров. За пару месяцев до презентации 14 сентября '
        'Apple разослала им сэмплы новых телефонов, и дизайн с разнесённым по '
        'диагонали блоком камер взбесил постоянных клиентов Apple и фанатов '
        'iPhone.';
    _resultLines = _maxLinesBool ? maxFreeLines : maxLines;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    infoWidget,
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

class EndWidget extends StatelessWidget {
  const EndWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          CustomIcons.favorite,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        ' 25  ',
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                onTap: () => print('cc'),
                splashColor: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {},
              child: Icon(Icons.share),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                overlayColor: MaterialStateProperty.all(Colors.grey),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size(60, 30)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),)),
              ),
            ),
          ],
        ),
        Divider(
          height: 1,
          color: Colors.black,
        )
      ],
    );
  }
}
