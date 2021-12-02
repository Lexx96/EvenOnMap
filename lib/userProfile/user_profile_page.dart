import 'dart:io';

import 'package:event_on_map/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/userProfile/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../main_driwer/main_drawer.dart';
import 'bloc/user_profile_image_bloc.dart';
import 'bloc/user_profile_image_bloc_state.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  late UserProfileImageBloc _bloc;
  Map<String, String?> _userData = {};
  File _image = File('');

  TextStyle textStyle = const TextStyle(
      fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _bloc = UserProfileImageBloc();
    _bloc.getUserDataFromSharedPreferencesBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      body: StreamBuilder(
        stream: _bloc.streamPersonalData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return userProfilePageBody(context, snapshot);
        },
      ),
    );
  }

  /// Тело UserProfilePage
  Container userProfilePageBody(BuildContext context, AsyncSnapshot snapshot) {

    if (snapshot.data is LoadedImageUserProfile) {
      final _data = snapshot.data as LoadedImageUserProfile;
      _image = _data.image as File;
    }
    if (snapshot.data is GetUserDataFromSharedPreferencesState) {
      final _data = snapshot.data as GetUserDataFromSharedPreferencesState;
      _userData = _data.userData;
      _bloc.readUserProfileImageBloc();
    }

    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                          child: Stack(
                            children: [
                              (snapshot.data is EmptyImageUserProfile)
                                  ? FlutterLogo(size: 160)
                                  : SizedBox.shrink(),
                              (snapshot.data is LoadingImageUserProfile)
                                  ? Stack(
                                children: [
                                  FlutterLogo(size: 160),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              )
                                  : SizedBox.shrink(),
                              snapshot.data is LoadedImageUserProfile || snapshot.data is GetUserDataFromSharedPreferencesState
                                  ? ClipOval(
                                child: Image.file(
                                  _image,
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : SizedBox.shrink(),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                                    splashColor: Colors.grey[1],
                                    onTap: () {
                                      (snapshot.data is EmptyImageUserProfile)
                                          ? _showImagesSource(context)
                                          : _showActions(context);
                                    } //_showActions(context, index),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( _userData['userName'] == null || _userData['userName'] == '' ?
                                S.of(context).name : _userData['userName'] as String,
                                  style: const TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5.0,),
                                Text( _userData['userSurname'] == null || _userData['userSurname'] == '' ?
                                S.of(context).surname : _userData['userSurname'] as String,
                                  style: const TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 35)),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                          MainNavigationRouteName.changePersonalDataPage,
                              (route) => false),
                      child: Text(
                        S.of(context).edit,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    size: 24,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    S.of(context).city,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Text(_userData['userCity'] == null || _userData['userCity'] == '' ?
                              S.of(context).city : _userData['userCity'] as String,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 24,
                                  ),
                                  SizedBox(width: 15),
                                  Text(S.of(context).phoneNumber,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              Text(_userData['phoneNumber'] == null || _userData['phoneNumber'] == '' ?
                              S.of(context).phoneNumber : _userData['phoneNumber'] as String,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.work_outline,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'О себе',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                              Text(_userData['aboutMe'] == null || _userData['aboutMe'] == '' ?
                              'О себе' : _userData['aboutMe'] as String,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Мои события'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 360,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            left: 8.0,
                            top: 8.0,
                            bottom: 16.0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 195,
                                width: 90,
                                decoration: BoxDecoration(
                                  color:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 8,
                                        offset: Offset(0, 2))
                                  ],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: FlutterLogo(
                                        size: 100,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          onTap:
                                              () {} //_showActions(context, index),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Выбор аватарки: камера, галерея
  _showImagesSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                _bloc.addPersonalImageBloc(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(Icons.camera_alt), Text('Камера')],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _bloc.addPersonalImageBloc(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(Icons.photo), Text('Галерея')],
              ),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Камера'),
              onTap: () {
                _bloc.addPersonalImageBloc(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Галерея'),
              onTap: () {
                _bloc.addPersonalImageBloc(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  /// Действия с аватаркой
  _showActions(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(Icons.image), Text('Открыть')],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                _bloc.deleteUserProfileImageBloc();
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(Icons.delete_outline), Text('Удалить')],
              ),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Открыть'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text('Удалить'),
              onTap: () {
                _bloc.deleteUserProfileImageBloc();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
