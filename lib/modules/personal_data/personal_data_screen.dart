// import 'package:event_on_map/generated/l10n.dart';
// import 'package:event_on_map/personal_data_page/widgets/switch_private_additional_information_widget.dart';
// import 'package:event_on_map/personal_data_page/widgets/switch_private_information_widget.dart';
// import 'package:flutter/material.dart';
// import 'widgets/header_pages_widget.dart';
//
// class PersonalDataPageWidget extends StatefulWidget {
//   const PersonalDataPageWidget({Key? key}) : super(key: key);
//
//   @override
//   _PersonalDataPageWidgetState createState() => _PersonalDataPageWidgetState();
// }
//
// class _PersonalDataPageWidgetState extends State<PersonalDataPageWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 10 * 3,
//                 width: double.infinity,
//                 color: Colors.blue,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 10 * 7,
//                 width: double.infinity,
//                 color: Colors.grey[300],
//               ),
//             ],
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 16, right: 16, top: 16),
//             child: ListView(
//               children: [
//                 HeaderPagesWidget(),
//                 LikesRowWidget(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(S.of(context).basicInformation + ':',
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ContactInformationWidget(),
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(S.of(context).detailedInformation + ':',
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 DetailedInformationWidget(),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class LikesRowWidget extends StatelessWidget {
//   const LikesRowWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       child: ListView(scrollDirection: Axis.horizontal, children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(
//               width: 20,
//             ),
//             TextButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.white),
//                   foregroundColor: MaterialStateProperty.all(Colors.blue),
//                   overlayColor: MaterialStateProperty.all(Colors.grey),
//                   shadowColor: MaterialStateProperty.all(Colors.grey),
//                   elevation: MaterialStateProperty.all(5),
//                   padding: MaterialStateProperty.all(EdgeInsets.all(25)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   )),
//                   alignment: Alignment.topCenter),
//               onPressed: () {},
//               child: Text(S.of(context).myLikes),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             TextButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.white),
//                   foregroundColor: MaterialStateProperty.all(Colors.blue),
//                   overlayColor: MaterialStateProperty.all(Colors.grey),
//                   shadowColor: MaterialStateProperty.all(Colors.grey),
//                   elevation: MaterialStateProperty.all(5),
//                   padding: MaterialStateProperty.all(EdgeInsets.all(25)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   )),
//                   alignment: Alignment.topCenter),
//               onPressed: () {},
//               child: Text(S.of(context).comments),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             TextButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.white),
//                   foregroundColor: MaterialStateProperty.all(Colors.blue),
//                   overlayColor: MaterialStateProperty.all(Colors.grey),
//                   shadowColor: MaterialStateProperty.all(Colors.grey),
//                   elevation: MaterialStateProperty.all(5),
//                   padding: MaterialStateProperty.all(EdgeInsets.all(25)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   )),
//                   alignment: Alignment.topCenter),
//               onPressed: () {},
//               child: Text(S.of(context).myAnswers),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }
// }
//
// class ContactInformationWidget extends StatelessWidget {
//   const ContactInformationWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             SwitchPrivateInformationWidget(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 15),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: 15),
//                 Text(S.of(context).city,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 TextButton(
//                     onPressed: () {},
//                     child: Text(S.of(context).novokuznetsk,
//                       style: TextStyle(fontSize: 15, color: Colors.black),
//                     )),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(S.of(context).phoneNumber,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     SizedBox(height: 15),
//                     Icon(
//                       Icons.phone,
//                       color: Colors.green,
//                       size: 24,
//                     ),
//                     SizedBox(width: 15),
//                     Text(
//                       '8-913-432-20-00',
//                       style: TextStyle(color: Colors.black, fontSize: 15),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 15),
//                 Divider(
//                   height: 1,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: 15),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DetailedInformationWidget extends StatelessWidget {
//   const DetailedInformationWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             SwitchPrivateAdditionalInformationWidget(),
//             Divider(
//               height: 1,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 Text(S.of(context).cityOfStay,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 SizedBox(width: 15),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(
//                   Icons.home,
//                   color: Colors.green,
//                   size: 24,
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Expanded(
//                     child: Text(S.of(context).cityOfStay + " : " + S.of(context).novokuznetsk,
//                       style: TextStyle(color: Colors.black54, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Divider(
//               height: 1,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(S.of(context).education,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 SizedBox(width: 15),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(
//                   Icons.home_work_outlined,
//                   color: Colors.green,
//                   size: 24,
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Expanded(
//                     child: Text(S.of(context).nameOfTheEducationalInstitution,
//                       style: TextStyle(color: Colors.black54, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Divider(
//               height: 1,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(S.of(context).aboutMe,
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//                 SizedBox(width: 15),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(
//                   Icons.home,
//                   color: Colors.green,
//                   size: 24,
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: Expanded(
//                     child: Text(S.of(context).informationAboutYourselfInAFreeForm,
//                       style: TextStyle(color: Colors.black54, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Divider(
//               height: 1,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
