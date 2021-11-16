import 'dart:convert';
import 'package:event_on_map/create_event/bloc/create_event/create_event_bloc.dart';
import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:http/http.dart';

import 'create_event_repository.dart';

class PostNewEventProvider {
  /// Размещение нового события на сервер
  Future<NewEventModel> postNewEvent({
    String? title,
    String? description,
    String? lat,
    String? lng,
  }) async {
    final _newEventModel = NewEventModel(
      title: title,
      description: description,
      lat: lat,
      lng: lng,
    ).toJson();

    final Response response =
        await PostEventRepository.postNewEvent(_newEventModel);

    NewEventModel newEventModel = NewEventModel();
    if (response.statusCode == 201) {
      try {
        final newJSonModelList =
            jsonDecode(response.body) as Map<String, dynamic>;
        final newJSonModel = NewEventModel.fromJson(newJSonModelList);
        return newJSonModel;
      } catch (error) {
        print('Ошибка запроса на размещение события $error');
        return newEventModel;
      }

      // вынести классы ошибок в отдельный файл
    } else if (response.statusCode == 400) {
      throw PostEvenErrorSendingServerException;
    } else if (response.statusCode == 500) {
      throw PostEventNotRegisteredSendingServerException;
    } else {
      return newEventModel;
    }
  }
}
