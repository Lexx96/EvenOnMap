import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../custom_icons.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late bool _createAnEventWidgetBool;

  void _changeCreateAnEventWidgetBool() {
    if (_createAnEventWidgetBool) {
      _createAnEventWidgetBool = !_createAnEventWidgetBool;
    } else {
      _createAnEventWidgetBool = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _createAnEventWidgetBool = false;
  }

  @override
  Widget build(BuildContext context) {
    final _showCreateAnEventWidget =
        _createAnEventWidgetBool ? CreateAnEventWidget() : null;
    final icon = _createAnEventWidgetBool ? Icons.close : Icons.add_rounded;
    final _myLocation = LatLng(53.769997, 87.137535);
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _myLocation,
            zoom: 16,
          ),
        ),
        Container(
          child: _showCreateAnEventWidget,
        ),
      ],
    ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _changeCreateAnEventWidgetBool();
              });
            },
            child: Icon(
              icon,
              size: 30,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              // цвет фона
              overlayColor: MaterialStateProperty.all(Colors.grey),
              // цвет анимации при нажатии
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              // отступ внутренний
              minimumSize: MaterialStateProperty.all(Size(60, 60)),
              // минимальный размер кнопки
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                // скругление краев кнопки
                  borderRadius: BorderRadius.circular(60),
                  side: BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ) // цвет бордера
              )),
            ),
          ),
          SizedBox(width: 10,),
          TextButton(
            onPressed: () {},
            child: Icon(
              CustomIcons.direction,
              size: 30,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.grey),
              shadowColor:
              MaterialStateProperty.all(Colors.lightGreenAccent),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size(60, 60)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ) // цвет бордера
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAnEventWidget extends StatefulWidget {
  const CreateAnEventWidget({Key? key}) : super(key: key);

  @override
  _CreateAnEventWidgetState createState() => _CreateAnEventWidgetState();
}

class _CreateAnEventWidgetState extends State<CreateAnEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,left: 16, right: 16, bottom: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2, color: Colors.black38,)
        ),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Создать событие',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    autofocus: false,
                    maxLines: 1,
                    maxLength: 50,
                    decoration: InputDecoration(
                      enabled: true,
                      fillColor: Colors.grey[200],
                      // изминение цвета фона TextField
                      filled: true,
                      // управление изминением цвета фона
                      hintText: 'Заголовок',
                      // подсказка в поле ввода, пропадает при начале ввода
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(15),

                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(20),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),

                      disabledBorder: OutlineInputBorder(
                          //  в не актоивном состоянии
                          borderRadius: BorderRadius.circular(20),
                          // скругление рамки поля ввода
                          borderSide: BorderSide(
                            width: 1.0, // ширина рамки поля ввода
                            color: Colors.grey, // цвет рамки поля ввода
                          )),

                      //errorText: 'Ошибка',     // текст ошибки под полем ввода
                      errorBorder: OutlineInputBorder(
                        // с ошибкой
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color: Colors.red, // цвет рамки поля ввода
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        // с ошибкой и в фокусе
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color:
                              Colors.red, // цвет рамки поля ввода
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    maxLines: DefaultTextStyle.of(context).maxLines,
                    minLines: 10,
                    maxLength: 1500,
                    decoration: InputDecoration(
                      enabled: true,
                      fillColor: Colors.grey[200],
                      // изминение цвета фона TextField
                      filled: true,
                      // управление изминением цвета фона
                      hintText: 'Тело события',
                      // подсказка в поле ввода, пропадает при начале ввода
                      hintStyle: TextStyle(color: Colors.grey),
                      hintMaxLines: 2,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(15),

                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(20),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),

                      disabledBorder: OutlineInputBorder(
                        //  в не актоивном состоянии
                          borderRadius: BorderRadius.circular(20),
                          // скругление рамки поля ввода
                          borderSide: BorderSide(
                            width: 1.0, // ширина рамки поля ввода
                            color: Colors.grey, // цвет рамки поля ввода
                          )),

                      //errorText: 'Ошибка',     // текст ошибки под полем ввода
                      errorBorder: OutlineInputBorder(
                        // с ошибкой
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color: Colors.red, // цвет рамки поля ввода
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        // с ошибкой и в фокусе
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color:
                          Colors.red, // цвет рамки поля ввода
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Укажите адресс',
                        style: TextStyle(
                            fontSize: 16,),
                      ),
                    ],
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
