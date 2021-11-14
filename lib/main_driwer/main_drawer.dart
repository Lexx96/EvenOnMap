import 'dart:io';

import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc.dart';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:flutter/material.dart';
import '../custom_icons_icons.dart';
import '../generated/l10n.dart';
import 'bloc/main_drawer_bloc.dart';
import 'bloc/main_drawer_state.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late final MainDrawerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MainDrawerBloc();
    _bloc.emptyMainDrawerState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 320,
            child: DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black.withOpacity(0.2)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(90)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 8,
                              offset: Offset(0, 2))
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child:
                      StreamBuilder(
                        stream: _bloc.streamController,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data is EmptyMainDrawerState) {
                            return FlutterLogo(
                              size: 160 );
                          }
                          if (snapshot.data is LoadedImageUserProfileForDrawer) {
                            final _data = snapshot.data as LoadedImageUserProfileForDrawer;
                            final _image = _data.image as File;
                            return ClipOval(
                              child: Image.file(
                                _image,
                                height: 160,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Expanded(
                        child: Text(
                          S.of(context).name +
                              ' ' +
                              S.of(context).surname,
                          style: TextStyle(fontSize: 19,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  CustomIcons.alarm,
                  size: 26,
                ),
                SizedBox(width: 7),
                Text('Уведомления'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/InPut');
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Row(
              children: [
                Icon(CustomIcons.user_2,),
                SizedBox(width: 10),
                Text(S.of(context).profile),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MainNavigationRouteName.userProfile);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(CustomIcons.picture_1),
                SizedBox(
                  width: 10,
                ),
                Text('Темы'),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MainNavigationRouteName.decorationPage);
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Row(
              children: [
                Icon(CustomIcons.italic),
                SizedBox(
                  width: 10,
                ),
                Text('О приложении'),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MainNavigationRouteName.aboutApplication);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  CustomIcons.envelope,
                  size: 26,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('Обратная связь'),
              ],
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MainNavigationRouteName.feedbackPage);
            },
          ),
          SizedBox(
            height: 120,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  CustomIcons.off,
                  color: Colors.red,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Выйти',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
