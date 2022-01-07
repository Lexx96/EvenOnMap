import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/modules/main_screen/main_screen.dart';
import 'package:event_on_map/modules/news/models/news.dart';
import 'package:event_on_map/utils/custom_icons/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Виджет вывода в карточку события фото пользователя,
/// его имени и времени размещения события
class HeaderButtonWidget extends StatefulWidget {
  final GetNewsFromServerModel _newsResponse;
  HeaderButtonWidget(this._newsResponse, {Key? key}) : super(key: key);

  @override
  State<HeaderButtonWidget> createState() => _HeaderButtonWidgetState();
}

class _HeaderButtonWidgetState extends State<HeaderButtonWidget> {
  final _url = 'http://23.152.0.13:3000/files/user/';

  @override
  Widget build(BuildContext context) {

    final _userData = widget._newsResponse.user;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: (_userData['photo'] != null &&
                      _userData['photo']['photo'] != null)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            _url + _userData['photo']['photo'],
                          ),
                          radius: 27,
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 27,
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userData['username'] != null && _userData['surname'] != null
                          ? _userData['username'] + ' ' + _userData['surname']
                          : S.of(context).incognito,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _dataTimeWidget(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
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
                      1, LatLng(widget._newsResponse.lat, widget._newsResponse.lng)),
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
  String _dataTimeWidget() {
    var _dataTimeNow = new DateTime.now().toString();
    var _dataTimeFromServer = widget._newsResponse.createdAt.toString();

    if (_dataTimeFromServer.substring(8, 10) == _dataTimeNow.substring(8, 10)) {
      return 'Сегодня в ' + _dataTimeFromServer.substring(12, 16);
    } else {
      return _dataTimeFromServer.substring(8, 10) +
          '.' +
          _dataTimeFromServer.substring(5, 7) +
          '.' +
          _dataTimeFromServer.substring(0, 4) +
          ' в ' +
          _dataTimeFromServer.substring(11, 16);
    }
  }
}

