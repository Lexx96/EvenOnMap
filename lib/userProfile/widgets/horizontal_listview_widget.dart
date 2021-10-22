


import 'package:event_on_map/generated/l10n.dart';
import 'package:flutter/material.dart';

class HorizontalListViewWidget extends StatelessWidget {
  const HorizontalListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey,
                  ),
                  Text(S.of(context).name),
                  Text(S.of(context).surname),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}