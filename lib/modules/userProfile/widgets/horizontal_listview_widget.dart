//
//
//
// import 'package:event_on_map/generated/l10n.dart';
// import 'package:flutter/material.dart';
//
// class HorizontalListViewWidget extends StatelessWidget {
//   const HorizontalListViewWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 240,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         itemBuilder: (BuildContext context, int index) {
//           return Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 16.0,),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: Colors.black.withOpacity(0.2)),
//                         borderRadius: BorderRadius.all(Radius.circular(90)),
//                         boxShadow: [
//                           BoxShadow(color: Colors.black, blurRadius: 8, offset: Offset(0, 2))
//                         ],
//                       ),
//                       clipBehavior: Clip.hardEdge,
//                       child: Stack(
//                         children: [
//                           FlutterLogo(
//                             size: 100,
//                           ),
//                           Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                                 borderRadius: BorderRadius.all(Radius.circular(90)),
//                                 splashColor: Colors.grey[1],
//                                 onTap: () {} //_showActions(context, index),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(S.of(context).name),
//                     Text(S.of(context).surname),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }