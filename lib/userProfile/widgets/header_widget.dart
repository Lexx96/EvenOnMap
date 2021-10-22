
import 'dart:io';
import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc.dart';
import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
/*
добавить возможность редактиования картинки
обновлять картинку сразу после выбора
 */

class UserProfileHeaderWidget extends StatefulWidget {
   UserProfileHeaderWidget({
    Key? key,
   }) : super(key: key);

  @override
  State<UserProfileHeaderWidget> createState() => _UserProfileHeaderWidgetState();
}

class _UserProfileHeaderWidgetState extends State<UserProfileHeaderWidget> {

  late UserProfileImageBloc _bloc;
  List<File> _userProfileImageList = [];

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
    }
    else {
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
                _userProfileImageList.clear();
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
                _userProfileImageList.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
  Stack _userProfileImage(BuildContext context ) {
    return Stack(
      children: [
        _userProfileImageList.isNotEmpty
            ? Center(
          child: Image.file(
            _userProfileImageList.first,
            height: 100,
            width: 100,
          ),
        )
            : FlutterLogo(
          size: 100,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              splashColor: Colors.grey[1],
              onTap: () {
                (_userProfileImageList.isEmpty)
                    ? _showImagesSource(context)
                    : _showActions(context);
              } //_showActions(context, index),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _bloc = UserProfileImageBloc();
    _bloc.emptyUserProfileBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //images != null ? _userProfileImage.add(images) : _userProfileImage;
    return StreamBuilder(
    stream: _bloc.streamPersonalData,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.data is EmptyImageUserProfile){
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black.withOpacity(0.2)),
                  borderRadius:
                  BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 8,
                        offset: Offset(0, 2))
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child:  _userProfileImage(context),
              ),
              const SizedBox(
                width: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).name +
                        ' ' +
                        S.of(context).surname,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.of(context).status,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).wasOnline,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.phone_android,
                        size: 14,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }
      if (snapshot.data is LoadingImageUserProfile){
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black.withOpacity(0.2)),
                      borderRadius:
                      BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 8,
                            offset: Offset(0, 2))
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: _userProfileImage(context),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).name +
                            ' ' +
                            S.of(context).surname,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        S.of(context).status,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).wasOnline,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.phone_android,
                            size: 14,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(child: CircularProgressIndicator(),)
          ],
        );
      }
      if (snapshot.data is LoadedImageUserProfile){
        LoadedImageUserProfile _data = snapshot.data as LoadedImageUserProfile;
        final _imageUserProfile = _data.image;
        _imageUserProfile != null ?  _userProfileImageList.add(_imageUserProfile) : _userProfileImageList;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black.withOpacity(0.2)),
                  borderRadius:
                  BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 8,
                        offset: Offset(0, 2))
                  ],
                ),
                  clipBehavior: Clip.hardEdge,
                child: _userProfileImage(context)),
              const SizedBox(
                width: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).name +
                        ' ' +
                        S.of(context).surname,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.of(context).status,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).wasOnline,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.phone_android,
                        size: 14,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.black.withOpacity(0.2)),
                borderRadius:
                BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: Offset(0, 2))
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Center(child: CircularProgressIndicator(),),
            ),
            const SizedBox(
              width: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).name +
                      ' ' +
                      S.of(context).surname,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  S.of(context).status,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).wasOnline,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.phone_android,
                      size: 14,
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },);

  }
}