// import 'dart:io';
// import 'package:event_on_map/generated/l10n.dart';
// import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc.dart';
// import 'package:event_on_map/userProfile/bloc/user_profile_image_bloc_state.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UserProfileHeaderWidget extends StatefulWidget {
//   UserProfileHeaderWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<UserProfileHeaderWidget> createState() =>
//       UserProfileHeaderWidgetState();
// }
//
// class UserProfileHeaderWidgetState extends State<UserProfileHeaderWidget> {
//   late UserProfileImageBloc _bloc;
//
//   TextStyle textStyle = const TextStyle(
//       fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold);
//
//   @override
//   void initState() {
//     super.initState();
//     _bloc = UserProfileImageBloc();
//     _bloc.emptyUserProfileImageBloc();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _bloc.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _bloc.streamPersonalData,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return _bodyHeaderWidget(snapshot);
//       },
//     );
//   }
//
//   /// Тело виджета
//   Stack _bodyHeaderWidget(AsyncSnapshot snapshot) {
//     File image = File('');
//     if (snapshot.data is LoadedImageUserProfile){
//       final _data = snapshot.data as LoadedImageUserProfile;
//       image = _data.image as File;
//     }
//
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 160,
//                 width: 160,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   border:
//                   Border.all(color: Colors.black.withOpacity(0.2)),
//                   borderRadius: BorderRadius.all(Radius.circular(90)),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black,
//                         blurRadius: 8,
//                         offset: Offset(0, 2))
//                   ],
//                 ),
//                 clipBehavior: Clip.hardEdge,
//                 child: Stack(
//                   children: [
//                     (snapshot.data is EmptyImageUserProfile) ? FlutterLogo(size: 160) : SizedBox.shrink(),
//                     (snapshot.data is LoadingImageUserProfile) ? Stack(
//                       children: [
//                         FlutterLogo(size: 160),
//                         CircularProgressIndicator(),
//                       ],
//                     ) : SizedBox.shrink(),
//                     (snapshot.data is LoadedImageUserProfile) ? ClipOval(
//                       child: Image.file(
//                         image,
//                         height: 160,
//                         width: 160,
//                         fit: BoxFit.cover,
//                       ),
//                     ) : SizedBox.shrink(),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                           borderRadius:
//                           BorderRadius.all(Radius.circular(90)),
//                           splashColor: Colors.grey[1],
//                           onTap: () {
//                             (snapshot.data is EmptyImageUserProfile)
//                                 ? _showImagesSource(context)
//                                 : _showActions(context);
//                           } //_showActions(context, index),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               Column(
//                 children: [
//                   Text(
//                     S.of(context).name + ' ' + S.of(context).surname,
//                     style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// Выбор аватарки: камера, галерея
//   _showImagesSource(BuildContext context) async {
//     if (Platform.isIOS) {
//       return showCupertinoModalPopup<ImageSource>(
//         context: context,
//         builder: (context) => CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               onPressed: () {
//                 _bloc.addPersonalImageBloc(ImageSource.camera);
//                 Navigator.of(context).pop();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [Icon(Icons.camera_alt), Text('Камера')],
//               ),
//             ),
//             CupertinoActionSheetAction(
//               onPressed: () {
//                 _bloc.addPersonalImageBloc(ImageSource.gallery);
//                 Navigator.of(context).pop();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [Icon(Icons.photo), Text('Галерея')],
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return showModalBottomSheet(
//         context: context,
//         builder: (context) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text('Камера'),
//               onTap: () {
//                 _bloc.addPersonalImageBloc(ImageSource.camera);
//                 Navigator.of(context).pop();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo),
//               title: Text('Галерея'),
//               onTap: () {
//                 _bloc.addPersonalImageBloc(ImageSource.gallery);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   /// Действия с аватаркой
//   _showActions(BuildContext context) async {
//     if (Platform.isIOS) {
//       return showCupertinoModalPopup<ImageSource>(
//         context: context,
//         builder: (context) => CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [Icon(Icons.image), Text('Открыть')],
//               ),
//             ),
//             CupertinoActionSheetAction(
//               onPressed: () {
//                 _bloc.deleteUserProfileImageBloc();
//                 Navigator.of(context).pop();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [Icon(Icons.delete_outline), Text('Удалить')],
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return showModalBottomSheet(
//         context: context,
//         builder: (context) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.image),
//               title: Text('Открыть'),
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.delete_outline),
//               title: Text('Удалить'),
//               onTap: () {
//                 _bloc.deleteUserProfileImageBloc();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
