import 'package:flutter/material.dart';

class CreateAnEventWidget extends StatelessWidget {
  const CreateAnEventWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Создать событие',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              maxLines: 1,
              maxLength: 50,
              decoration: InputDecoration(
                enabled: true,
                fillColor: Colors.grey[200],
                filled: true,
                hintText: 'Заголовок',
                hintStyle: const TextStyle(color: Colors.grey),
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(15),

                enabledBorder: OutlineInputBorder(
                  // рабочее , но не активное состояние
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  // в фокусе
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2.0,
                    color: Colors.blue,
                  ),
                ),

                disabledBorder: OutlineInputBorder(
                  //  в не актоивном состоянии
                    borderRadius: BorderRadius.circular(20),
                    // скругление рамки поля ввода
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    )),

                //errorText: 'Ошибка',     // текст ошибки под полем ввода
                errorBorder: OutlineInputBorder(
                  // с ошибкой
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1.0, // ширина рамки поля ввода
                    color: Colors.red, // цвет рамки поля ввода
                  ),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  // с ошибкой и в фокусе
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1.0, // ширина рамки поля ввода
                    color:
                    Colors.red, // цвет рамки поля ввода
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              maxLines: DefaultTextStyle.of(context).maxLines,
              minLines: 10,
              maxLength: 1500,
              decoration: InputDecoration(
                enabled: true,
                fillColor: Colors.grey[200],
                filled: true,
                hintText: 'Тело события',
                hintStyle: const TextStyle(color: Colors.grey),
                hintMaxLines: 2,
                isCollapsed: true,
                contentPadding: EdgeInsets.all(15),

                enabledBorder: OutlineInputBorder(
                  // рабочее , но не активное состояние
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  // в фокусе
                  borderRadius: BorderRadius.circular(20),
                  // скругление каждого угла отдельно
                  borderSide: const BorderSide(
                    width: 2.0,
                    color: Colors.blue,
                  ),
                ),

                disabledBorder: OutlineInputBorder(
                  //  в не актоивном состоянии
                    borderRadius: BorderRadius.circular(20),
                    // скругление рамки поля ввода
                    borderSide: const BorderSide(
                      width: 1.0, // ширина рамки поля ввода
                      color: Colors.grey, // цвет рамки поля ввода
                    )),

                //errorText: 'Ошибка',     // текст ошибки под полем ввода
                errorBorder: OutlineInputBorder(
                  // с ошибкой
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1.0, // ширина рамки поля ввода
                    color: Colors.red, // цвет рамки поля ввода
                  ),
                ),

                focusedErrorBorder: OutlineInputBorder(
                  // с ошибкой и в фокусе
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1.0, // ширина рамки поля ввода
                    color:
                    Colors.red, // цвет рамки поля ввода
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Укажите адресс',
                  style: const TextStyle(
                    fontSize: 16,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}