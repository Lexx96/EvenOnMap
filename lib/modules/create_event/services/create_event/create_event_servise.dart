import 'dart:convert';
import 'dart:io';
import 'package:event_on_map/modules/create_event/bloc/create_event/create_event_bloc.dart';
import 'package:event_on_map/modules/create_event/models/post_event_model.dart';
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
        final newJsonModel = NewEventModel.fromJson(newJSonModelList);
        return newJsonModel;
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

  /// Размещение изображений к событию по id события
  static Future<void> postNewEventImages ({required List<File?> listImages, required String? idEvent}) async{
    try{
      if (listImages.isNotEmpty) {
        PostEventRepository.postNewEventImages(listImages: listImages, idEvent: idEvent);
      }
    }catch(e){
      throw Exception(e);
    }
  }
}
