import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom_icons.dart';

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