import 'package:event_on_map/generated/l10n.dart';
import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class ChangePersonalDataPage extends StatelessWidget {
  const ChangePersonalDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(S.of(context).name),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Ведите имя',
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.all(15),

                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(10),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(S.of(context).surname),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Ведите имя',
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(10),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),

                      disabledBorder: OutlineInputBorder(
                        //  в не актоивном состоянии
                          borderRadius: BorderRadius.circular(10),
                          // скругление рамки поля ввода
                          borderSide: BorderSide(
                            width: 1.0, // ширина рамки поля ввода
                            color: Colors.grey, // цвет рамки поля ввода
                          )),

                      //errorText: 'Ошибка',     // текст ошибки под полем ввода
                      errorBorder: OutlineInputBorder(
                        // с ошибкой
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color: Colors.red, // цвет рамки поля ввода
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        // с ошибкой и в фокусе
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2.0, // ширина рамки поля ввода
                          color:
                          Colors.red, // цвет рамки поля ввода
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(S.of(context).status),
                  TextField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Статус',
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(10),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  Text(S.of(context).hometown),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Город',
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(10),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),

                      disabledBorder: OutlineInputBorder(
                        //  в не актоивном состоянии
                          borderRadius: BorderRadius.circular(10),
                          // скругление рамки поля ввода
                          borderSide: BorderSide(
                            width: 1.0, // ширина рамки поля ввода
                            color: Colors.grey, // цвет рамки поля ввода
                          )),

                      //errorText: 'Ошибка',     // текст ошибки под полем ввода
                      errorBorder: OutlineInputBorder(
                        // с ошибкой
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color: Colors.red, // цвет рамки поля ввода
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        // с ошибкой и в фокусе
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2.0, // ширина рамки поля ввода
                          color:
                          Colors.red, // цвет рамки поля ввода
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(S.of(context).aboutMe),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLines: DefaultTextStyle.of(context).maxLines,
                    minLines: 10,
                    maxLength: 1500,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Расскажите о себе',
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        // рабочее , но не активное состояние
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        // в фокусе
                        borderRadius: BorderRadius.circular(10),
                        // скругление каждого угла отдельно
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.blue,
                        ),
                      ),

                      disabledBorder: OutlineInputBorder(
                        //  в не актоивном состоянии
                          borderRadius: BorderRadius.circular(10),
                          // скругление рамки поля ввода
                          borderSide: BorderSide(
                            width: 1.0, // ширина рамки поля ввода
                            color: Colors.grey, // цвет рамки поля ввода
                          )),

                      //errorText: 'Ошибка',     // текст ошибки под полем ввода
                      errorBorder: OutlineInputBorder(
                        // с ошибкой
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1.0, // ширина рамки поля ввода
                          color: Colors.red, // цвет рамки поля ввода
                        ),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        // с ошибкой и в фокусе
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2.0, // ширина рамки поля ввода
                          color:
                          Colors.red, // цвет рамки поля ввода
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(S.of(context).save, style: const TextStyle(fontSize: 17),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
    MainNavigationRouteName.userProfile,  (route) => false),
            child: Text(S.of(context).back, style: const TextStyle(fontSize: 17),),
          ),
        ],
      ),
    );
  }
}
