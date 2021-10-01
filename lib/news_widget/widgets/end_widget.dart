import 'package:flutter/material.dart';

import '../../custom_icons.dart';

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