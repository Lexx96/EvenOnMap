import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../custom_icons_icons.dart';

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
                          CustomIcons.heart_1,
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
            TextButton(
              onPressed: () => Share.share('text'),  //https://www.youtube.com/watch?v=-PmUFbbA-Fs
              child: Icon(Icons.share),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                overlayColor: MaterialStateProperty.all(Colors.grey),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(Size(60, 30)),

              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}