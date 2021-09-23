import 'package:event_on_map/map_widget/map_widget.dart';
import 'package:event_on_map/newsWidget/news_widget.dart';
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
      appBar: AppBar(),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          NewsWidget(),
          MapWidget(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedFontSize: 16,
        selectedFontSize: 18,
        selectedIconTheme: IconThemeData(
          size: 30,
          color: Colors.blue,
        ),
        unselectedIconTheme: IconThemeData(size: 25, color: Colors.grey),
        selectedLabelStyle: TextStyle(fontSize: 17),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.event_sharp,
              ),
              label: 'Новости'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'Карта'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_rounded),
              label: 'Профиль'),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
