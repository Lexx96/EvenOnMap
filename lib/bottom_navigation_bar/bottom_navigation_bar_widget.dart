// import 'package:event_on_map/generated/l10n.dart';
// import 'package:event_on_map/navigation/main_navigation.dart';
// import 'package:flutter/material.dart';
// import '../custom_icons_icons.dart';
//
// class BottomNavigationBarWidget extends StatefulWidget {
//   const BottomNavigationBarWidget({Key? key}) : super(key: key);
//
//   @override
//   _BottomNavigationBarWidgetState createState() =>
//       _BottomNavigationBarWidgetState();
// }
//
// class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
//   int _selectedTab = 0;
//
//   void onSelectTab(int index) {
//     if (_selectedTab == index) return;
//     setState(
//       () {
//         _selectedTab = index;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       child: BottomNavigationBar(
//         selectedIconTheme: IconThemeData(
//           size: 30,
//         ),
//         currentIndex: _selectedTab,
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 CustomIcons.home,
//               ),
//               label: S.of(context).news),
//           BottomNavigationBarItem(
//             icon: Icon(CustomIcons.map_marker),
//             label: S.of(context).map,
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(CustomIcons.user_2), label: S.of(context).profile),
//         ],
//         onTap: (index){
//           onSelectTab(index);
//           if (index == 0) {
//             Navigator.of(context).pushNamed(MainNavigationRouteName.newsWidget);
//           }
//           else if (index == 1) {
//             Navigator.of(context).pushNamed(MainNavigationRouteName.mapWidget);
//           }
//           else if (index == 2) {
//             Navigator.of(context).pushNamed(MainNavigationRouteName.userProfile);
//           }
//         },
//       ),
//     );
//   }
// }
