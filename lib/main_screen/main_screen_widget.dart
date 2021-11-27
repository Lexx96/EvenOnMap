import 'dart:io';

import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/map_widget/map_widget.dart';
import 'package:event_on_map/news_page/news_pages.dart';
import 'package:event_on_map/userProfile/user_profile_page.dart';
import 'package:flutter/material.dart';
import '../custom_icons_icons.dart';

class MainScreen extends StatefulWidget {
final int indexPage;
MainScreen({Key? key,required this.indexPage}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState(indexPage);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;
  late int indexPage;
  _MainScreenState(this.indexPage);



  @override
  void initState() {
    super.initState();
    _indexPage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: IndexedStack(
          index: _selectedTab,
          children: [
            NewsPage(),
            MapWidget(),
            UserProfilePage(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(
              size: 30,
            ),
            currentIndex: _selectedTab,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    CustomIcons.home,
                  ),
                  label: S.of(context).news),
              BottomNavigationBarItem(
                icon: Icon(CustomIcons.map_marker),
                label: S.of(context).map,
              ),
              BottomNavigationBarItem(
                  icon: Icon(CustomIcons.user_2),
                  label: S.of(context).profile),
            ],
            onTap: _onSelectTab,
          ),
        ),
      ),
    );
  }


  /// Выбор экрана при переходе на MainScreen
  void _indexPage () {
    setState(() {
      _selectedTab = indexPage;
    });
  }

  /// Выбор экрана по нажатию на BottomNavigationBar
   void _onSelectTab(int index) {
    indexPage = index;
     if (_selectedTab == index) return;
     setState(() {
       _selectedTab = index;
     });
   }
}
