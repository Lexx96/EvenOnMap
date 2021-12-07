import 'dart:convert';
import 'dart:io';
import 'package:event_on_map/userProfile/services/user_profile_repository.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class UserProfileProvider {
  /// Доступ к галереи и камере устройства для выбора фотографии на аватарку
  Future<File?> getImageFileUserProfile(ImageSource source) async {
    try {
      final _imageXFile = await userProfileImageXFile(source);
      final image = File(_imageXFile!.path);
      return image;
    } catch (error) {
      print('Ошибка получения изображения от репозитория $error');
    }
  }

  /// Загрузка аватарки на сервер
  static Future<void> postUserImageProvider ({required File? image}) async{
    try{
      if (image != null) {
        PostUserDataOnServerRepository.postUserImageRepository(image: image);
      }
    }catch(e){
      throw Exception(e);
    }
  }

  /// Сохранение аватарки в память устрйства
  Future<void> writePhotoInMemory(File photo) async {
    final directory = await pathProvider.getTemporaryDirectory();
    final filePath = '${directory.path}/photo.jpeg';
    final File file = File(filePath);
    final bytesPhoto = await photo.readAsBytes();

    if (await file.exists()) {
      await deletePhoto(file);
      await writePhoto(bytesPhoto, file);
    } else {
      await file.create();
      await writePhoto(bytesPhoto, file);
    }
  }

  /// Удаление аватарки из памяти устройства
  Future<void> deletePhotoFromMemory() async {
    final directory = await pathProvider.getTemporaryDirectory();
    final filePath = '${directory.path}/photo.jpeg';
    File file = File(filePath);
    await deletePhoto(file);
  }

  /// Проверка наличия записанного файла
  Future<bool> isExistUserPhoto() async {
    try {
      final directory = await pathProvider.getTemporaryDirectory();
      final filePath = '${directory.path}/photo.jpeg';
      File file = File(filePath);
      if (await file.exists()) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Чтение аватарки из памяти устройства
  Future<File?> readPhotoFromMemory() async {
    final directory = await pathProvider.getTemporaryDirectory();
    final filePath = '${directory.path}/photo.jpeg';
    File file = File(filePath);

    bool fileExists = await isExistUserPhoto();
    if (fileExists) {
      readPhoto(file).then(
        (_fileUnit8FromMemory) {
          file = File.fromRawPath(_fileUnit8FromMemory);
        },
      ).catchError(
        (e) {
          throw Exception(e);
        },
      );
      return file;
    }
    throw Exception('file not exists');
  }

  /// Сохранение данных о пользователе на сервер
  Future<void> postUserDataOnServerProvider({
    required String name,
    required String surName,
    String? patronimyc,
    String? email,
    String? city,
  }) async {
    try{
      await PostUserDataOnServerRepository.postUserDataOnServerRepository(
        name: name,
        surName: surName,
        email: email,
        city: city,
        patronimyc: patronimyc,
      );
    }catch(e){
      throw Exception(e);
    }
  }

  /// Сохранение данных о пользователе в SharedPreferences
  Future<void> saveUserDataInSharedPreferences({
    String? name,
    String? surName,
    String? patronimyc,
    String? email,
    String? city,
    String? aboutMe,
    String? phoneNumber
  }) async {
    print(city);
    print('1111111111111111111111111111111111');
    try {
      if (name != null) {
        await SaveAndReadDataFromSharedPreferences().saveNameData(name: name);
      }
      if (surName != null) {
        await SaveAndReadDataFromSharedPreferences().saveSurNameData(surName: surName);
      }
      if (patronimyc != null) {
        await SaveAndReadDataFromSharedPreferences().savePatronimycData(patronimyc: patronimyc);
      }
      if (email != null) {
        await SaveAndReadDataFromSharedPreferences().saveEmailData(email: email);
      }
      if (city != null) {
        await SaveAndReadDataFromSharedPreferences().saveCityNameData(city: city);
      }
      if (aboutMe != null) {
        await SaveAndReadDataFromSharedPreferences().saveAboutMeData(aboutMe: aboutMe);
      }
      if (phoneNumber != null) {
        await SaveAndReadDataFromSharedPreferences().savePhoneNumberData(phoneNumber: phoneNumber);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Получение всех данных о пользователе с серера и сохранение в SharedPreferences
  Future<void> getDataFromServerAndSaveInSharedPreferencesProvider() async {
    try {
      Response _response = await PostUserDataOnServerRepository.getDataFromServerRepository();

      if(_response.statusCode == 200) {
        final jsonUserDataMap = jsonDecode(_response.body) as Map<String, dynamic>;
        await saveUserDataInSharedPreferences(
          name: jsonUserDataMap['username'],
          surName: jsonUserDataMap['surname'],
          patronimyc: jsonUserDataMap['patronimyc'],
          city: jsonUserDataMap['city'],
          email: jsonUserDataMap['email'],
        );
        // final jsonUserDataModel = UserDataModel.fromJson(jsonUserDataMap);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Получение всех данных о пользователе из SharedPreferences
  Future<Map<String, String?>> getDataFromSharedPreferencesProvider() async {
    try {
      return await SaveAndReadDataFromSharedPreferences().readUserData();
    } catch (e) {
      throw Exception(e);
    }
  }
}
