

import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Text('Тут будет что то'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
