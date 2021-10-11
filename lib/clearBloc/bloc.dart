import 'dart:async';

import 'package:event_on_map/clearBloc/repository.dart';
import 'package:event_on_map/clearBloc/states.dart';

class ServiceClearBloc {
  late final ClearRepository _clearRepository;
  ServiceClearBloc(this._clearRepository);

  final _streamController = StreamController<ClearBlocState>();
  Stream<ClearBlocState> get streamGetter => _streamController.stream;

  loading(String phone, String password) {
    _streamController.sink.add(ClearBlocState.loading());



    // Преобразуем данные в модель для отправки запроса (UserRegistrationModel)
    // и передаем в метод репозитория непосредственно заполненную модель преобразованную в Json

    _clearRepository.registration(phone, password).then((value) => {
      //Тут придет ответ с сервера в JSON формате, преобразуем его в модель (UserData) и возвращаем новое состояние потока
    });

    _clearRepository.registration(phone, password).then((value) => {
      _streamController.sink.add(ClearBlocState.response(value))
    });
  }

  dispose() {
    _streamController.close();
  }
}

