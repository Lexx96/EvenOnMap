import 'dart:io';

import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
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
  late File _image;

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
    return StreamBuilder(
      stream: _bloc.streamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data is LoadedImageUserProfileForDrawerState) {
          final _data = snapshot.data as LoadedImageUserProfileForDrawerState;
          _image = _data.image as File;
        }
        return Stack(
          children: [
            Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        height: 320.0,
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
                                    borderRadius: BorderRadius.all(Radius.circular(90)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 8,
                                          offset: Offset(0, 2))
                                    ],
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child:
                                  snapshot.data is EmptyMainDrawerState
                                      ? FlutterLogo(size: 160)
                                      : ClipOval(
                                    child: Image.file(
                                      _image,
                                      height: 160,
                                      width: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child: Text(
                                    S.of(context).name + ' ' + S.of(context).surname,
                                    style: TextStyle(
                                      fontSize: 19,
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
                      Divider(),
                      ListTile(
                        title: Row(
                          children: [
                            Icon(
                              CustomIcons.user_2,
                            ),
                            SizedBox(width: 10),
                            Text(S.of(context).profile),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MainNavigationRouteName.userProfile);
                        },
                      ),
                      Divider(),
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
                      Divider(),
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
                      Divider(),
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
                      Divider(),
                      SizedBox(
                        height: 50,
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
                        onTap: () => _bloc.showMessage(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            snapshot.data is ShowMessageState ? _showMessage() : SizedBox.shrink()
          ],
        );
      },
    );
  }

  Widget _showMessage() {
    return AlertDialog(
      title: Center(
          child: Text(
        '''Вы точно хотите выйти ?''',
      )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () =>_bloc.closeAlertDialog(),
              child: Text('Отмена'),
            ),
            TextButton(
                onPressed: () async {
                  await WriteAndReadDataFromSecureStorage
                      .deleteUserPasswordAndLogIn();
                  Navigator.of(context)
                      .pushReplacementNamed(MainNavigationRouteName.auth);
                },
                child: Text('Выйти')),
          ],
        ),
      ],
    );
  }
}
