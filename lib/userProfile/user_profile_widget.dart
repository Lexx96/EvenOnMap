import 'package:event_on_map/newsWidget/news_widget.dart';
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
    return Stack(
      children: [
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      colors: [
                    Color(0xffffffff),
                    Color(0xffffffff),
                  ])),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/mapOne.png'),
                          backgroundColor: Colors.red,
                          radius: 40,
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Имя Фамилия',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Статус',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  'когда был в сети',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
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
                        onPressed: () {},
                        child: Text(
                          'Редактировать',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  SizedBox(
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
                            Text(
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
                            Text(
                              '   Запись',
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
                            Text(
                              '   Фото',
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
                            Text(
                              '   История',
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  SizedBox(
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
                            SizedBox(width: 15),
                            Text(
                              'Город: переменная с названием города',
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.airline_seat_recline_extra_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Место учебы',
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work_outline,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Место работы',
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.more_horiz,
                              color: Colors.blue,
                              size: 24,
                            ),
                            SizedBox(width: 15),
                            TextButton(
                                onPressed: () => Navigator.of(context).pushNamed('personalDataPage'),
                                child: Text(
                                  'Подробная информация',
                                  style: TextStyle(
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
                  Divider(
                    height: 1,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('Друзья 354',
                                style: TextStyle(
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
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.grey,
                                  ),
                                  Text('Имя'),
                                  Text('Фамилия'),
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
                          HeaderButtonWidget(),
                          TextBodyWidget(),
                          EndWidget(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }
}
