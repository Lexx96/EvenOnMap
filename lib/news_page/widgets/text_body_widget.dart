// import 'package:event_on_map/generated/l10n.dart';
// import 'package:event_on_map/news_page/models/news.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class TextBodyWidget extends StatefulWidget {
//   final GetNewsFromServerModel _newsResponse;
//
//   TextBodyWidget(this._newsResponse, {Key? key}) : super(key: key);
//
//   @override
//   _TextBodyWidgetState createState() => _TextBodyWidgetState(_newsResponse);
// }
//
// class _TextBodyWidgetState extends State<TextBodyWidget> {
//   final GetNewsFromServerModel _newsResponse;
//
//   _TextBodyWidgetState(this._newsResponse);
//
//   late bool _maxLinesBool;
//   late int _resultLines;
//
//   final List<String> images = [
//     'https://im0-tub-ru.yandex.net/i?id=16d9e6eddcbdfdeba9de432422bca25e-l&n=13',
//     'https://get.wallhere.com/photo/2560x1600-px-clear-sky-forest-landscape-pine-trees-road-sky-summer-1413157.jpg',
//     'https://w-dog.ru/wallpapers/9/17/322057789001671/zakat-nebo-solnce-luchi-oblaka-tuchi-pole-kolosya-zelenye-trava.jpg',
//     'https://im0-tub-ru.yandex.net/i?id=16d9e6eddcbdfdeba9de432422bca25e-l&n=13',
//     'https://get.wallhere.com/photo/2560x1600-px-clear-sky-forest-landscape-pine-trees-road-sky-summer-1413157.jpg',
//     'https://w-dog.ru/wallpapers/9/17/322057789001671/zakat-nebo-solnce-luchi-oblaka-tuchi-pole-kolosya-zelenye-trava.jpg',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _maxLinesBool = true;
//     _resultLines = 3;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _maxThreeLines = 3;
//     final _maxLines = DefaultTextStyle.of(context).maxLines;
//     final _resultLines = _maxLinesBool ? _maxThreeLines : _maxLines;
//
//     return Container(
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: _titleText(),
//                     ),
//                     Expanded(child: Text('')),
//                   ],
//                 ),
//               ),
//               _newsResponse.title.length == 0
//                   ? SizedBox.shrink()
//                   : SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: _descriptionText(_resultLines),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 16.0, right: 16.0, bottom: 10.0),
//                 child: _isButton(),
//               ),
//             ],
//           ),
//           bodyImageWidget(),
//         ],
//       ),
//     );
//   }
//
//   /// Вывод изображений
//   Column bodyImageWidget() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           child: Image(
//             image: NetworkImage(images[1]),
//           ),
//         ),
//         SizedBox(
//           height: 5.0,
//         ),
//         SizedBox(
//           height: 150.0,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               physics: BouncingScrollPhysics(),
//               itemCount: images.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Row(
//                   children: [
//                     Image(
//                       image: NetworkImage(images[index]),
//                     ),
//                     SizedBox(
//                       width: 5.0,
//                     )
//                   ],
//                 );
//               }),
//         ),
//       ],
//     );
//   }
//
//   /// Вывод title
//   Widget _titleText() {
//     if (_newsResponse.title.length == 0) {
//       return SizedBox.shrink();
//     } else {
//       return Text(
//         _newsResponse.title,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       );
//     }
//   }
//
//   /// Вывод description
//   Widget _descriptionText(int? _resultLines) {
//     if (_newsResponse.description.length == 0) {
//       return SizedBox.shrink();
//     } else {
//       return Text(
//         _newsResponse.description,
//         maxLines: _resultLines,
//         overflow: TextOverflow.fade,
//       );
//     }
//   }
//
//   /// Вывод кнопки "Подробнее ..."
//   Widget _isButton() {
//     if (_newsResponse.description.length > 147 && _maxLinesBool == true) {
//       return TextButton(
//         onPressed: () {
//           setState(
//             () {
//               if (_maxLinesBool) {
//                 _maxLinesBool = !_maxLinesBool;
//               } else {
//                 _maxLinesBool = true;
//               }
//             },
//           );
//         },
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           minimumSize: MaterialStateProperty.all(Size(50, 30)),
//           backgroundColor: MaterialStateProperty.all(Colors.transparent),
//           foregroundColor: MaterialStateProperty.all(Colors.grey),
//           padding: MaterialStateProperty.all(EdgeInsets.zero),
//         ),
//         child: Text(S.of(context).inMoreDetail),
//       );
//     } else {
//       return SizedBox.shrink();
//     }
//   }
// }
