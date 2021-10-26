import 'package:event_on_map/create_event/bloc/create_event/create_event_bloc.dart';
import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  late final ServiceNewEventBloc _bloc;
  final _headerTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

  NewEventModel headerAndBodyText () {
    final _textFromTitle = _headerTextController.text;
    print(_textFromTitle);
    final _textFromDescription = _bodyTextController.text;
    final modelEvent = NewEventModel(title: _textFromTitle, description: _textFromDescription);
    return modelEvent;
  }

  @override
  void initState() {
    super.initState();
    ServiceNewEventBloc _bloc ;
    _headerTextController.addListener(headerAndBodyText);
    _bodyTextController.addListener(headerAndBodyText);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Создать событие',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
                borderRadius: BorderRadius.circular(10),
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
                  color: Colors.red, // цвет рамки поля ввода
                ),
              ),
            ),
            controller: _headerTextController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Divider(
              height: 1,
            ),
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
                borderRadius: BorderRadius.circular(10),
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
                  color: Colors.red, // цвет рамки поля ввода
                ),
              ),
            ),
            controller: _bodyTextController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Divider(
              height: 1,
            ),
          ),
          Center(
            child: Text('Добавить фото'),
          ),
        ],
      ),
    );
  }
}