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
            onTap: () {},
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
                    Text(
                      S.of(context).userNickname, // избежать оверфлоу
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '48 ' + S.of(context).minutesAgo,
                      style: TextStyle(fontSize: 12),
                    ),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                          1, LatLng(_newsResponse.lat, _newsResponse.lng))));
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
}
