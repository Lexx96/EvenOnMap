import 'package:event_on_map/custom_icons.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 180,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                S.of(context).name + ' ' + S.of(context).surname,
                                style:
                                TextStyle(color: Colors.white, fontSize: 19),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight + Alignment(0, .3),
                              child: Text(S.of(context).mail,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.add_alert_rounded),
                  Text('Уведомления'),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/InPut');
              },
            ),
            Divider(height: 1,),
            ListTile(
              title: Row(
                children: [
                  Icon(CustomIcons.user),
                  Text(S.of(context).profile),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed(MainNavigationRouteName.userProfile);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.image),
                  Text('Оформление'),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/InPut');
              },
            ),
            Divider(height: 1,),
            ListTile(
              title: Row(
                children: [
                  Icon(CustomIcons.people),
                  Text('О приложении'),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed(MainNavigationRouteName.licenseAgreement);
              },
            ),
          ],
        ),);
  }
}