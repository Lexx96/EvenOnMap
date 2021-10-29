import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'models/post_event_model.dart';
import 'widgets/images_widget.dart';
import 'bloc/create_event/create_event_bloc_state.dart';
import 'bloc/create_event/create_event_bloc.dart';
import 'widgets/form_widget.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  late ServiceNewEventBloc _bloc;

  final _headerTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

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

  Widget _showException(AsyncSnapshot snapshot) {
    if (snapshot.data is EventLoadedBloc) {
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
    } else if (snapshot.data is PostEventNotRegisteredSendingServer) {
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
              if (snapshot.data is EventEmptyBloc ||
                  snapshot.data is EventLoadingBloc ||
                  snapshot.data is EventLoadedBloc ||
                  snapshot.data is PostEvenErrorSendingServer ||
                  snapshot.data is PostEventNotRegisteredSendingServer) {
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
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 15.0),
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
                                decoration: InputDecoration(
                                  enabled: true,
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: 'Заголовок',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                                  errorBorder: OutlineInputBorder(
                                    // с ошибкой
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      width: 1.0, // ширина рамки поля ввода
                                      color:
                                          Colors.red, // цвет рамки поля ввода
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
                                controller: _headerTextController,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Divider(height: 1),
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
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                                        color: Colors
                                            .grey, // цвет рамки поля ввода
                                      )),

                                  //errorText: 'Ошибка',     // текст ошибки под полем ввода
                                  errorBorder: OutlineInputBorder(
                                    // с ошибкой
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      width: 1.0, // ширина рамки поля ввода
                                      color:
                                          Colors.red, // цвет рамки поля ввода
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
                                controller: _bodyTextController,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Divider(height: 1),
                              ),
                              Center(
                                child: Text('Добавить фото'),
                              ),
                              TextButton(
                                  onPressed: () => _postNewEventInServer(),
                                  child: Text('123'))
                            ],
                          ),
                        ),
                        ImagesWidget(),
                        GetLatLngWidget(bloc: _bloc),
                      ],
                    ),
                    snapshot.data is EventLoadingBloc
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox.shrink(),
                    _showException(snapshot),
                  ],
                );
              }
              if (snapshot.data is GetLatLng) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(53.769997, 87.137535),
                    zoom: 16,
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class GetLatLngWidget extends StatelessWidget {
  const GetLatLngWidget({
    Key? key,
    required ServiceNewEventBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

  final ServiceNewEventBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Укажите место',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () => _bloc.getLatLngOnMap(),
              child: Icon(
                CustomIcons.location,
                color: Colors.blue,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                overlayColor: MaterialStateProperty.all(Colors.grey),
                elevation: MaterialStateProperty.all(0),
                minimumSize: MaterialStateProperty.all(Size(60, 30)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
