// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../bloc/pick_image/pick_image_bloc.dart';
// import '../bloc/pick_image/pick_image_bloc_state.dart';
//
// class ImagesWidget extends StatefulWidget {
//   const ImagesWidget({Key? key}) : super(key: key);
//
//   @override
//   State<ImagesWidget> createState() => ImagesWidgetState();
// }
//
// class ImagesWidgetState extends State<ImagesWidget> {
//   final selectedImages = <File?>[];
//   late PickImageBloc _bloc;
//
//   @override
//   void initState() {
//     super.initState();
//     _bloc = PickImageBloc();
//     _bloc.notSelectedPickImage();
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
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
//       child: SizedBox(
//         height: 220,
//         child: StreamBuilder(
//           stream: _bloc.streamPickImage,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             print(snapshot.data);
//             if (snapshot.data is LoadedPickImage) {
//               LoadedPickImage _data = snapshot.data as LoadedPickImage;
//               final _images = _data.image;
//               selectedImages.add(_images);
//               _bloc.notSelectedPickImage();
//             }
//             return (selectedImages.length == 0)
//                 ? Row(
//                     children: [
//                       _isButton(),
//                     ],
//                   )
//                 : ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: selectedImages.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Row(
//                         children: [
//                           _showImages(context, index, snapshot),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           (selectedImages.length <= 6 &&
//                                   index == selectedImages.length - 1)
//                               ? _isButton()
//                               : SizedBox.shrink(),
//                         ],
//                       );
//                     },
//                   );
//           },
//         ),
//       ),
//     );
//   }
//
//
//   /// Карточка вывода изображения
//   Container _showImages(BuildContext context, int index, AsyncSnapshot<dynamic> snapshot) {
//     return Container(
//                           height: 195,
//                           width: 90,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             border: Border.all(
//                                 color: Colors.black.withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10)),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black,
//                                   blurRadius: 8,
//                                   offset: Offset(0, 2))
//                             ],
//                           ),
//                           clipBehavior: Clip.hardEdge,
//                           child: Stack(
//                             children: [
//                               Center(
//                                   child: Image.file(
//                                       selectedImages[index] as File),),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       (snapshot.data is LoadedPickImage ||
//                                               snapshot.data
//                                                   is NotSelectedPickImage)
//                                           ? Icon(
//                                               Icons.done,
//                                               color: Colors.deepOrange,
//                                               size: 18,
//                                             )
//                                           : SizedBox(
//                                               height: 20,
//                                               width: 20,
//                                               child:
//                                                   CircularProgressIndicator()),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               Material(
//                                 color: Colors.transparent,
//                                 child: InkWell(
//                                   onTap: () => _showActions(context, index),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//   }
//
//   /// Выбор источника изображения
//   _showCardAdd(BuildContext context) async {
//     if (Platform.isIOS) {
//       return showCupertinoModalPopup<ImageSource>(
//         context: context,
//         builder: (context) => CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               onPressed: () {
//                 _bloc.addPickImageBloc(ImageSource.camera);
//                 Navigator.of(context).pop();
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [Icon(Icons.camera_alt), Text('Камера')],
//               ),
//             ),
//             CupertinoActionSheetAction(
//               onPressed: () {
//                 _bloc.addPickImageBloc(ImageSource.gallery);
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
//                 _bloc.addPickImageBloc(ImageSource.camera);
//                 Navigator.of(context).pop();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo),
//               title: Text('Галерея'),
//               onTap: () {
//                 _bloc.addPickImageBloc(ImageSource.gallery);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   /// Действия с выбранным изображением
//   _showActions(BuildContext context, index) async {
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
//                 selectedImages.removeAt(index);
//                 _bloc.notSelectedPickImage();
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
//                 selectedImages.removeAt(index);
//                 _bloc.notSelectedPickImage();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   /// Карточка вывода карточки добавить фото
//   Widget _isButton() {
//     return Container(
//       height: 195,
//       width: 90,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black,
//               blurRadius: 8,
//               offset: Offset(0, 2))
//         ],
//       ),
//       clipBehavior: Clip.hardEdge,
//       child: TextButton(
//         onPressed: () => _showCardAdd(context),
//         child: Icon(
//           Icons.add_rounded,
//           color: Theme.of(context).iconTheme.color,
//           size: 45,
//         ),
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
//         ),
//       ),
//     );
//   }
// }
