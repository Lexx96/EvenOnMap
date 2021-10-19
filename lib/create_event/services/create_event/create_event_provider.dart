import 'dart:convert';

import 'package:event_on_map/create_event/models/post_event_model.dart';
import 'package:http/http.dart';

import 'create_event_repository.dart';

class PostNewEventProvider {
  Future<List<NewEventModel>> postNewEvent(
    String title,
    String description,
    String id,
    double lat,
    double lng,
    String userId,
    String createAt,
    String updateAt,
  ) async {
    final _newEventModel = NewEventModel(
      title: title,
      description: description,
      id: id,
      userId: userId,
      lat: lat,
      lng: lng,
      createAt: createAt,
      updateAt: userId,
    ).toJson();

    final Response response =
        await PostEventRepository.postNewEvent(_newEventModel);
    List<NewEventModel> newEventModel = [];

    if (response.statusCode == 201) {
      try {
        final newJSonModelList = jsonDecode(response.body) as List<dynamic>;

        final newJSonMode = newJSonModelList
            .map((dynamic newJSonModelMap) =>
                NewEventModel.fromJson(newJSonModelMap))
            .toList();

        return newJSonMode;
      } catch (_) {
        return newEventModel;
      }
    }
    return newEventModel;
  }
}
