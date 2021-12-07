import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/main_screen/main_screen_widget.dart';
import 'package:event_on_map/news_page/models/news.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../custom_icons_icons.dart';

class HeaderButtonWidget extends StatefulWidget {
  final GetNewsFromServerModel _newsResponse;

  HeaderButtonWidget(this._newsResponse, {Key? key}) : super(key: key);

  @override
  State<HeaderButtonWidget> createState() =>
      _HeaderButtonWidgetState(_newsResponse);
}

class _HeaderButtonWidgetState extends State<HeaderButtonWidget> {
  late GetNewsFromServerModel _newsResponse;

  _HeaderButtonWidgetState(this._newsResponse);



  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // _newsResponse.user['id'];
            }, // открыть метод передать id
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('http://23.152.0.13:3000/files/user/' + _newsResponse.user['photo']['photo']), //_newsResponse.user.photo.firs
                    radius: 27,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _newsResponse.user['username'] != null ? _newsResponse.user['username']  : 'Инкогнито',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    Text(
                      _dataTime(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,)
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MainScreen(
                      1, LatLng(_newsResponse.lat, _newsResponse.lng)),
                ),
              );
            },
            child: Icon(
              CustomIcons.map_marker,
              color: Colors.blue,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  /// Вывод времени размещения новости
  String _dataTime() {
    var _dataTimeNow = new DateTime.now().toString();
    var _dataTimeFromServer = _newsResponse.createdAt.toString();

    if(_dataTimeFromServer.substring(8,10) == _dataTimeNow.substring(8,10)){
      return 'Сегодня в ' + _dataTimeFromServer.substring(12,16);
    }else{
      return _dataTimeFromServer.substring(8,10)
          + '.' + _dataTimeFromServer.substring(5,7)
          + '.' + _dataTimeFromServer.substring(0,4)
          + ' в ' + _dataTimeFromServer.substring(12,16);
    }
  }
}
