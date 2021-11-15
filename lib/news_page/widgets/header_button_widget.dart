import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../custom_icons_icons.dart';

class HeaderButtonWidget extends StatelessWidget {
  const HeaderButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
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
                  Text(S.of(context).userNickname,                   // избежать оверфлоу
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
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
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
            onPressed: () {},
            child: Icon(
              CustomIcons.map_marker,
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
  // /// Получение информации о ранее выбранной теме и в зависимости от этого выбор цвета иконки
  // static Future<bool> _choiceTheme() async {
  //   final savedThemeMode = await AdaptiveTheme.getThemeMode();
  //   if (savedThemeMode == AdaptiveThemeMode.light) {
  //     return true;
  //   }else {
  //     return false;
  //   }
  // }
}