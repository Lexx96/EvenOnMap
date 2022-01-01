import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';

class HeaderPagesWidget extends StatelessWidget {
  const HeaderPagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/mapOne.png'),
              radius: 40,
            ),
            SizedBox(
              width: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).name + ' ' + S.of(context).surname,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  S.of(context).status,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(S.of(context).wasOnline,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.phone_android,
                      size: 14,
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}