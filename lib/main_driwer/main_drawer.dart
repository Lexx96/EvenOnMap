import 'dart:io';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
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
  Map<String, String?> _userNameAndSurname = {};
  File _image = File('');

  @override
  void initState() {
    super.initState();
    _bloc = MainDrawerBloc();
    _bloc.getUserDataFromSharedPreferencesMainDrawerBloc();
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

        if (snapshot.data is GetUserDataFromSharedPreferencesMainDrawerState) {
          final _data = snapshot.data as GetUserDataFromSharedPreferencesMainDrawerState;
          _userNameAndSurname = _data.userData;
          _bloc.readImageUserBloc();
        }

        return Stack(
          children: [
            Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        border: Border.all(
                                            color: Colors.black.withOpacity(0.2)),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(90)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 8,
                                              offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Stack(
                                        children: [
                                          (snapshot.data is EmptyMainDrawerState)
                                              ? FlutterLogo(size: 160)
                                              : SizedBox.shrink(),
                                          (snapshot.data is LoadingImageMainDrawerState)
                                              ? Stack(
                                            children: [
                                              FlutterLogo(size: 160),
                                              Center(child: CircularProgressIndicator()),
                                            ],
                                          )
                                              : SizedBox.shrink(),
                                          _image != File('')
                                              ? ClipOval(
                                            child: Image.file(
                                              _image,
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                            ),
                                          ) : SizedBox.shrink()
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text( _userNameAndSurname['userName'] == null || _userNameAndSurname['userName'] == '' ?
                                          S.of(context).name : _userNameAndSurname['userName'] as String,
                                            style: const TextStyle(
                                                fontSize: 22, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5.0,),
                                          Text( _userNameAndSurname['userSurname'] == null || _userNameAndSurname['userSurname'] == '' ?
                                          S.of(context).surname : _userNameAndSurname['userSurname'] as String,
                                            style: const TextStyle(
                                                fontSize: 22, fontWeight: FontWeight.bold),
                                          ),
                                        ],
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
                                Icon(CustomIcons.picture_1),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Темы'),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  MainNavigationRouteName.decorationPage);
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
                              Navigator.of(context).pushNamed(
                                  MainNavigationRouteName.aboutApplication);
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
                        ],
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
                        onTap: _bloc.showMessage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            snapshot.data is ShowMessageState
                ? _showMessage()
                : SizedBox.shrink()
          ],
        );
      },
    );
  }

  /// Подтверждение выхода из учетной записи
  Widget _showMessage() {
    return AlertDialog(
      title: Center(
          child: Text(
        '''Логин и пароль будут удалены. 
        
       Выйти из учетной записи ?''',
      )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => _bloc.closeAlertDialog(),
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
