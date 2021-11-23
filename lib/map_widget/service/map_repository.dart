import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';
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

  /// Получение информации о ранее выбранной теме и назначение новой темы
  static Future<String> choiceMapTheme() async {
    try{

      final savedThemeMode = await AdaptiveTheme.getThemeMode();

      String themeMap = '';

      if (AdaptiveThemeMode.system.isDark) {
         themeMap = 'assets/map_dark_theme/dark_theme.json';
      } else if (AdaptiveThemeMode.system.isLight) {
         themeMap = 'assets/map_dark_theme/light_theme.json';
      } else if (savedThemeMode == AdaptiveThemeMode.light) {
         themeMap = 'assets/map_dark_theme/light_theme.json';
      } else if (savedThemeMode == AdaptiveThemeMode.dark) {
         themeMap = 'assets/map_dark_theme/dark_theme.json';
      }
      return await rootBundle.loadString(themeMap);

    }catch(e){
      throw Exception(e);
    }
  }

  /// Получение темы для карты
  static Future<String> getJsonFile (String path) async{
    return await rootBundle.loadString(path);
  }
}
