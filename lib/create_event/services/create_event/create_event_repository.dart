import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart' as http;

class PostEventRepository {
  /// Получение токена из SharedPreferences при создании нового события
  static postNewEvent<Response>(Map<String, dynamic> eventJson) async {
    String _accessToken =
        await SetAndReadDataFromSharedPreferences().readAccessToken();

    return await http.post(
      Uri.parse('http://23.152.0.13:3000/news'),
      body: eventJson,
      headers: {'Authorization': 'Bearer ' + _accessToken},
    );
  }

  /// Размещение изображений к событию по id события
  static void postNewEventImages(
      {required List<File?> listImages, required String? idEvent}) async {
    try {
      String _accessToken =
          await SetAndReadDataFromSharedPreferences().readAccessToken();
      for (int i = 0; i < listImages.length; i++) {
        if (listImages[i] != null && listImages.asMap().containsKey(i) && idEvent != null) {
          final ByteStream stream = http.ByteStream(
              DelegatingStream.typed(listImages[i]!.openRead()));
          final int length = await listImages[i]!.length();
          final MultipartRequest request = http.MultipartRequest(
            "POST",
            Uri.parse('http://23.152.0.13:3000/news/files/photo'),
          );
          final MultipartFile multipartFile = http.MultipartFile(
              'file', stream, length,
              filename: basename(listImages[i]!.path));
          request.files.add(multipartFile);
          request.headers.addAll({'Authorization': 'Bearer ' + _accessToken});
          request.fields['id'] = idEvent;
          final StreamedResponse response= await request.send();
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
