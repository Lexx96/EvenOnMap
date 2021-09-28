import 'package:event_on_map/create_an_event_widget/create_an_event_widget.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
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
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(MainNavigationRouteName.createAnEventWidget),
            child: Icon(
              Icons.add_rounded,
              size: 30,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              // цвет фона
              overlayColor: MaterialStateProperty.all(Colors.grey),
              // цвет анимации при нажатии
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              // отступ внутренний
              minimumSize: MaterialStateProperty.all(Size(45, 45)),
              // минимальный размер кнопки
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                // скругление краев кнопки
                  borderRadius: BorderRadius.circular(60),
                  side: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ) // цвет бордера
              )),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {},
            child: const Icon(
              CustomIcons.direction,
              size: 30,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.grey),
              shadowColor: MaterialStateProperty.all(Colors.lightGreenAccent),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size(45, 45)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(
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
