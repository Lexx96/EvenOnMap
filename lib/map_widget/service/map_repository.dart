import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRepository {


  /// Определение Position пользователя при инициализации карты
  static Future<Position> determinePositionGPS() async {
    return await Geolocator.getCurrentPosition();
  }

  /// Определение адреса по Position [package:geolocator]
  static Future<List<Placemark>> getAddressFromLatLong(
      double lat, double lng) async {
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(lat, lng);
      return placemark;
    } catch (e) {
      throw Exception('Не удалось получить адресс');
    }
  }

  /// Определение адреса по LatLng [package:geocoder]
  static Future<List<Address>> getAddress(LatLng onTabLatLng) async {
    // для обновления https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration#basic-plugin
    try {
      Coordinates coordinatesOnTab =
          Coordinates(onTabLatLng.latitude, onTabLatLng.longitude);
      List<Address> addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinatesOnTab);
      return addresses;
    } catch (e) {
      throw Exception(e);
    }
  }
}
