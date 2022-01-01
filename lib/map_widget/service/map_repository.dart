import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _SharedPreferencesKeys {
  static const _userLastLat = 'userLastLat';
  static const _userLastLng = 'userLastLng';
}



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
      throw Exception('Не удалось получить адресс $e');
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
       if (savedThemeMode == AdaptiveThemeMode.system) {
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

  /// Преобразование маркера из Asset в Uint8List и задание размера
   Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try{
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    }catch(e){
      throw Exception(e);
    }
  }
}


class SaveAndReadLatLngFromSharedPreferences {

  final _storage = SharedPreferences.getInstance();

  /// Сохранение последнего местоположения пользователя в SharedPreferences
  Future<void> saveLastLatLngUser({required String lat, required String lng}) async {
    try{
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._userLastLat, lat);
      await storage.setString(_SharedPreferencesKeys._userLastLng, lng);
    }catch(e) {
      throw Exception(e);
    }
  }

  /// Получение данных о последнем местоположении пользователя из SharedPreferences
  Future<LatLng?> readLastLatLngUser() async {
    final storage = await _storage;
    try{
      final lastLat = storage.getString(_SharedPreferencesKeys._userLastLat);
      final lastLng = storage.getString(_SharedPreferencesKeys._userLastLng);
      if(lastLng != null || lastLat != null) {
        final doubleLastLat = double.parse(lastLat!);
        final doubleLastLng = double.parse(lastLng!);
        return LatLng(doubleLastLat, doubleLastLng);
      }
      return null;
    }
    catch(e){
      throw Exception(e);
    }
  }
}
