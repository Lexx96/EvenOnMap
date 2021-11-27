import 'dart:io';
import 'package:event_on_map/userProfile/services/user_profile__image_repository.dart';
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
    } catch(e) {
      return false;
    }
  }

  /// Чтение аватарки из памяти устройства
  Future<File?> readPhotoFromMemory() async {
    final directory = await pathProvider.getTemporaryDirectory();
    final filePath = '${directory.path}/photo.jpeg';
    File file = File(filePath);

    bool fileExists = await isExistUserPhoto();
    if (fileExists){
      readPhoto(file).then((_fileUnit8FromMemory) {
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

  /// Сохранение данных о пользователе в SharedPreferences
  void saveUserDataInSharedPreferences ({String? name, String? surName, String? city, String? aboutMe, String? phoneNumber}) async {
    try{
      if(name != null) {
        await SaveAndReadDataFromSharedPreferences().saveNameData(name: name);
      }
      if(surName != null) {
        SaveAndReadDataFromSharedPreferences().saveSurNameData(surName: surName);
      }
      if(city != null) {
        SaveAndReadDataFromSharedPreferences().saveCityNameData(city: city);
      }
      if(aboutMe != null) {
        SaveAndReadDataFromSharedPreferences().saveAboutMeData(aboutMe: aboutMe);
      }
      if(phoneNumber != null) {
        SaveAndReadDataFromSharedPreferences().savePhoneNumberData(phoneNumber: phoneNumber);
      }
    }catch(e){
      throw Exception(e);
    }
  }

  /// Получение всех данных о пользователе из SharedPreferences
  Future<Map<String, String?>> getDataFromSharedPreferences () async {
    try{
      return await SaveAndReadDataFromSharedPreferences().readUserData();
    }catch(e){
      throw Exception(e);
    }
  }
}
