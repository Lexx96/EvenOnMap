import 'dart:io';
import 'dart:typed_data';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class _SharedPreferencesKeys {
  static const _userName = 'userName';
  static const _userSurname = 'userSurname';
  static const _userCity = 'userCity';
  static const _aboutMe = 'aboutMe';
  static const _phoneNumber = 'phoneNumber';
}

class PostUserDataOnServerRepository {

  /// Получение токена из SharedPreferences и сохранение данных о пользователе на сервер
  static postUserDataOnServerRepository({
    required String name,
    required String surName,
    String? email,
    String? city,
    String? patronimyc
  }) async {
    String _accessToken = await SetAndReadDataFromSharedPreferences().readAccessToken();

    return await http.post(
      Uri.parse('http://23.152.0.13:3000/user/update'),
      body: {
        "username": name,
        "surname": surName,
        "patronimyc": patronimyc,
        "city": city,
        "email": email
      },
      headers: {'Authorization': 'Bearer ' + _accessToken},
    );
  }
}

class SaveAndReadDataFromSharedPreferences {
  final _storage = SharedPreferences.getInstance();

  /// Сохранение имени пользователя в SharedPreferences
  Future<void> saveNameData({required String name}) async {
    try {
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._userName, name);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Сохранение номера телефона пользователя в SharedPreferences
  Future<void> savePhoneNumberData({required String phoneNumber}) async {
    try {
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._phoneNumber, phoneNumber);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Сохранение фамилии пользователя в SharedPreferences
  Future<void> saveSurNameData({required String surName}) async {
    try {
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._userSurname, surName);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Сохранение города в SharedPreferences
  Future<void> saveCityNameData({required String city}) async {
    try {
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._userCity, city);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Сохранение данных о пользователе в SharedPreferences
  Future<void> saveAboutMeData({required String aboutMe}) async {
    try {
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._aboutMe, aboutMe);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Получение всех данных о пользователе из SharedPreferences
  Future<Map<String, String?>> readUserData() async {
    final storage = await _storage;
    Map<String, String?> getUserData = {};
    try {
      getUserData[_SharedPreferencesKeys._userName] =
          storage.getString(_SharedPreferencesKeys._userName);
      getUserData[_SharedPreferencesKeys._userSurname] =
          storage.getString(_SharedPreferencesKeys._userSurname);
      getUserData[_SharedPreferencesKeys._userCity] =
          storage.getString(_SharedPreferencesKeys._userCity);
      getUserData[_SharedPreferencesKeys._aboutMe] =
          storage.getString(_SharedPreferencesKeys._aboutMe);
      getUserData[_SharedPreferencesKeys._phoneNumber] =
          storage.getString(_SharedPreferencesKeys._phoneNumber);
      return getUserData;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteUserData() async {
    final storage = await _storage;
    try {
      storage.clear();
    } catch (e) {
      throw Exception(e);
    }
  }
}

/// Доступ к галереи и камере устройства для выбора фотографии на аватарку
Future userProfileImageXFile(ImageSource source) async {
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    return image;
  } catch (e) {
    print('Ошибка выбора картинки $e');
  }
}

/// Сохранение аватарки в память устрйства
Future<File> writePhoto(Uint8List file, File path) async {
  try {
    return path.writeAsBytes(file);
  } catch (e) {
    throw Exception(e);
  }
}

/// Удаление аватарки из памяти устройства
Future<void> deletePhoto(File file) async {
  await file.delete(
      recursive: true); // Не полулилось разобраться с удалением(не удаляет)
}

/// Чтение аватарки из помяти устройства
Future<Uint8List> readPhoto(File file) async {
  try {
    final _fileUnit8FromMemory = await file.readAsBytes();
    return _fileUnit8FromMemory;
  } catch (e) {
    throw Exception('no photo');
  }
}
