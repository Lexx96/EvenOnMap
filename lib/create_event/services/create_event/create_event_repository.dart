import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PostEventRepository {

  /// Получение токена из SharedPreferences при создании нового события
  static postNewEvent<Response>(Map<String, dynamic> eventJson) async {

      String _accessToken = await SetAndReadAccessTokenFromSharedPreferences().readAccessToken();

          return await http.post(
            Uri.parse('http://23.152.0.13:3000/news'),
            body: eventJson,
            headers: {'Authorization': 'Bearer ' + _accessToken},
          );
  }

  /// Определение координат
  static Future<Position> determinePositionGPS () async {
    return await Geolocator.getCurrentPosition();
  }

  /// Определение адреса по Position [package:geocoding]
  static Future<List<Placemark>> getAddressFromLatLong (Position position) async {
    try{
      List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
      return placemark;
    }catch (e){
      throw Exception('Не удалось получить адресс');
    }
  }

  /// Определение адреса по LatLng [package:geolocator]
  static Future<List<Address>> getAddress (LatLng onTabLatLng) async {
    // для обновления https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration#basic-plugin
    try{
      // Получение Coordinates по LatLng
      Coordinates coordinatesOnTab = Coordinates(onTabLatLng.latitude, onTabLatLng.longitude);
      // Получение адреса по Coordinates
      List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(coordinatesOnTab);
      return addresses;
    }catch(e){
      throw Exception(e);
    }

  }

}
