import 'package:event_on_map/custom_icons.dart';
import 'package:event_on_map/map_widget/map_widget.dart';
import 'package:event_on_map/news_widget/news_widget.dart';
import 'package:event_on_map/userProfile/user_profile_widget.dart';
import 'package:flutter/material.dart';

/*

Класс с:
цветами
темами
иконками
шрифтами

Сделать дивайдей меню в профиле
форма заполнения личных данных
(
TextField(
    maxLines: null,
    keyboardType: TextInputType.multiline,
))
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
          NewsWidget(),
          MapWidget(),
          UserProfile(),
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
                CustomIcons.home_outline,
                size: 20,
              ),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.map_2, size: 20),
              label: 'Карта',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.user, size: 20),
              label: 'Профиль',
            ),
          ],
          onTap: onSelectTab,
        ),
      ),
    );
  }
}
