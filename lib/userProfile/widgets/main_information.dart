

import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class MainInformationWidget extends StatelessWidget {
  const MainInformationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.white),
                foregroundColor:
                MaterialStateProperty.all(Colors.blue),
                overlayColor:
                MaterialStateProperty.all(Colors.grey[300]),
                shadowColor:
                MaterialStateProperty.all(Colors.grey),
                elevation: MaterialStateProperty.all(3),
                padding:
                MaterialStateProperty.all(EdgeInsets.zero),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 35)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )),
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  MainNavigationRouteName.changePersonalDataPage,  (route) => false),
              child: Text(
                S.of(context).edit,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Row(
            children: [
              Icon(
                Icons.home,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 15),
              Text(
                S.of(context).city +
                    ': ' +
                    S.of(context).novokuznetsk,
                style: TextStyle(
                    color: Colors.black54, fontSize: 14),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.airline_seat_recline_extra_rounded,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 15),
              Text(
                S.of(context).placeOfStudy,
                style: TextStyle(
                    color: Colors.black54, fontSize: 14),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.work_outline,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 15),
              Text(
                S.of(context).placeOfWork,
                style: TextStyle(
                    color: Colors.black54, fontSize: 14),
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.more_horiz,
                color: Colors.blue,
                size: 24,
              ),
              const SizedBox(width: 15),
              TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(MainNavigationRouteName
                      .personalDataPage),
                  child: Text(
                    S.of(context).detailedInformation,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Divider(
            height: 1,
            color: Colors.black54,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text('Были рядом',
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}