import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/map_widget/map_widget.dart';
import 'package:event_on_map/news_page/news_pages.dart';
import 'package:event_on_map/userProfile/user_profile_page.dart';
import 'package:flutter/material.dart';

/*
Сделать скрол по страницам

Класс с:
цветами
темами
иконками
шрифтами

спеш скрин

анимированны иконки
(  class _CreatePackageViewState extends State<CreatePackageView>
with SingleTickerProviderStateMixin {
   bool expanded = true;
  AnimationController controller;
  @override
   void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
  }

  IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: controller,
          semanticLabel: 'Show menu',
        ),
        onPressed: () {
          setState(() {
            expanded ? controller.forward() : controller.reverse();
            expanded = !expanded;
          });
        }),

}
)



карточку в ленту новостей
и скролл в ленте
ListPage при первом входе
 */
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          NewsPage(),
          MapWidget(),
          UserProfilePage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          selectedIconTheme: IconThemeData(
            size: 30,
            color: Colors.blue,
          ),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          currentIndex: _selectedTab,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.event_sharp,
                ),
                label: S.of(context).news),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: S.of(context).map,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_rounded),
                label: S.of(context).profile),
          ],
          onTap: onSelectTab,
        ),
      ),
    );
  }
}
