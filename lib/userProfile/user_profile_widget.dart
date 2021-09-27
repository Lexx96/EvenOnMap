import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:event_on_map/news_widget/news_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment:Alignment.centerLeft,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment:Alignment.centerRight,
                                child:
                                Text('Имя фамилия', style: TextStyle(color: Colors.white, fontSize: 19),),
                              ),
                              Align(
                                alignment:Alignment.centerRight + Alignment(0, .3),
                                child:
                                Text('Почта@mail.ru',style: TextStyle(color: Colors.white, fontSize: 13)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('Профиль'),
                onTap: () {
                  Navigator.of(context).pushNamed('/UserPanel');
                },
              ),
              ListTile(
                title: Text('Регистрация'),
                onTap: () {
                  Navigator.of(context).pushNamed('/InPut');
                },
              ),
              ListTile(
                title: Text('О приложении'),
                onTap: () {
                  Navigator.of(context).pushNamed('/InPut');
                },
              ),
            ],
          )
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage('assets/images/mapOne.png'),
                        radius: 40,
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Имя Фамилия',
                            style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Статус',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Text(
                                'когда был в сети',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.phone_android,
                                size: 14,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        // цвет фона
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                        // цвет текста
                        overlayColor: MaterialStateProperty.all(Colors.grey[300]),
                        // цвет анимации при нажатии
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        // цвет тени
                        elevation: MaterialStateProperty.all(3),
                        // поднятие кнопки регулируется тенью
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        // отступ внутренний
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 35)),
                        // минимальный размер кнопки
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          // скругление краев кнопки
                          borderRadius: BorderRadius.circular(7),
                        )),
                      ),
                      onPressed: () => Navigator.of(context).pushNamed(MainNavigationRouteName.changePersonalDataPage),
                      child: const Text(
                        'Редактировать',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, size: 45, color: Colors.blue[200],),
                          ),
                          const Text(
                            '   История',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, size: 45, color: Colors.blue[200],),
                          ),
                          const Text(
                            '   Запись',
                            style: const TextStyle(color: Colors.blue, fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, size: 45, color: Colors.blue[200],),
                          ),
                          const Text(
                            '   Фото',
                            style: const TextStyle(color: Colors.blue, fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.photo_camera, size: 45, color: Colors.blue[200],),
                          ),
                          const Text(
                            '   История',
                            style: const TextStyle(color: Colors.blue, fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 1,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 24,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Город: переменная с названием города',
                            style: TextStyle(color: Colors.black54, fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.airline_seat_recline_extra_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Место учебы',
                            style: TextStyle(color: Colors.black54, fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.work_outline,
                            color: Colors.black,
                            size: 24,
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Место работы',
                            style: TextStyle(color: Colors.black54, fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.more_horiz,
                            color: Colors.blue,
                            size: 24,
                          ),
                          const SizedBox(width: 15),
                          TextButton(
                              onPressed: () => Navigator.of(context).pushNamed('personalDataPage'),
                              child: const Text(
                                'Подробная информация',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('Друзья 354',
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey,
                                ),
                                const Text('Имя'),
                                const Text('Фамилия'),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black.withOpacity(0.9))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HeaderButtonWidget(),
                        TextBodyWidget(),
                        const EndWidget(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
