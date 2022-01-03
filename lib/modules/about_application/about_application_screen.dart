
import 'package:event_on_map/utils/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AboutApplication extends StatelessWidget {
  const AboutApplication({Key? key}) : super(key: key);

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
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(width: 10,),
                        Text('Лицензионное соглашение'),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(MainNavigationRouteName.licenseAgreement);
                    },
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(width: 10,),
                        Text('О разработчике'),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(MainNavigationRouteName.aboutDeveloper);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
