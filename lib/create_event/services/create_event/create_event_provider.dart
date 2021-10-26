import 'dart:convert';

import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:http/http.dart';

import 'create_event_repository.dart';

class PostNewEventProvider {

  Future <NewEventModel> postNewEvent(
    String? title,
    String? description,
    double? lat,
    double? lng,
  ) async {
    final _newEventModel = NewEventModel(
      title: title,
      description: description,
      lat: lat,
      lng: lng,
    ).toJson();

    final Response response =
        await PostEventRepository.postNewEvent(_newEventModel);
    final newEventModel = {} as NewEventModel;

    if (response.statusCode == 201) {
      try {
        final newJSonModelList = jsonDecode(response.body) as Map<String, dynamic>;

        final newJSonModel = NewEventModel.fromJson(newJSonModelList);
        return newJSonModel;
      } catch (error) {
        print('Ошибка запроса на размещение события $error');
        return newEventModel;
      }
    }
    return newEventModel;
  }
}
