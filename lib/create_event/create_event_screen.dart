
import 'package:flutter/material.dart';
import '../custom_icons_icons.dart';
import 'widgets/images_widget.dart';
import 'bloc/create_event/create_event_bloc_state.dart';
import 'bloc/create_event/create_event_bloc.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  late ServiceNewEventBloc _bloc;

  final _headerTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewEventBloc();
    _bloc.emptyEventBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.streamEventController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _bodyCreateEvent(context, snapshot);
        },
      ),
    );
  }

  /// Тело экрана
  Stack _bodyCreateEvent(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16.0, bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Создать событие',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        maxLines: 1,
                        maxLength: 50,
                        decoration: _inputDecorationStyle('Заголовок'),
                        controller: _headerTextController,
                      ),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 15.0)),
                      TextField(
                        maxLines: DefaultTextStyle.of(context).maxLines,
                        minLines: 10,
                        maxLength: 1500,
                        decoration: _inputDecorationStyle('Тело события'),
                        controller: _bodyTextController,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Divider(height: 1),
                      ),
                      Center(
                        child: Text('Добавить фото')),
                    ],
                  ),
                ),
                ImagesWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Укажите место',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                          onPressed: () => _bloc.getLatLngOnMap(),
                          child: Icon(
                            CustomIcons.map_marker,
                            color: Colors.blue,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent),
                            overlayColor:
                            MaterialStateProperty.all(Colors.grey),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize:
                            MaterialStateProperty.all(Size(60, 30)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.grey[100]),
                      ),
                      onPressed: () => _postNewEventInServer(),
                      child: Text('Создать'),
                    ),
                    SizedBox(width: 28),
                  ],
                )
              ],
            ),
            snapshot.data is EventLoadingBlocState
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink(),
            _showException(snapshot),
            snapshot.data is EventLoadingBlocState ? Center(child: CircularProgressIndicator()) : SizedBox.shrink()
          ],
        );
  }

  /// Стиль декорации для TextField
  InputDecoration _inputDecorationStyle(String _hintText) {
    return InputDecoration(
                          enabled: true,
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: _hintText,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: Colors.blue,
                            ),
                          ),
                        );
  }

  /// Показывает уведомления пользователю в AlertDialog
  Widget _showException(AsyncSnapshot snapshot) {
    if (snapshot.data is EventLoadedBlocState) {
      return AlertDialog(
        title: Center(
            child: Text(
              'Новость успешно добавлена!\n \nПосле проверки модератором она будет опубликованна',
            )),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyEventBloc(),
            child: Text('OK'),
          ),
        ],
      );
    } else if (snapshot.data is PostEvenErrorSendingServerException) {
      return AlertDialog(
        title: Center(
            child: Text(
              'Произошла ошибка \n \nПовторите попытку!',
            )),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyEventBloc(),
            child: Text('OK'),
          ),
        ],
      );
    } else if (snapshot.data is PostEventNotRegisteredSendingServerState) {
      return AlertDialog(
        title: Center(
            child: Text(
              'Ошибка регистрации при добавлении события \n \nПовторите попытку!',
            )),
        actions: [
          TextButton(
            onPressed: () => _bloc.emptyEventBloc(),
            child: Text('OK'),
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Размещение нового события на сервер
  void _postNewEventInServer() {
    final _textFromTitle = _headerTextController.text;
    final _textFromDescription = _bodyTextController.text;
    final String lat;
    final String lng;
    _bloc.loadingPostEventBloc(
        title: _textFromTitle,
        description: _textFromDescription,
        lng: '5.1',
        lat: '10.1');
  }
}
