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
    final directory = await pathProvider.getTemporaryDirectory();   // как проверить есть ли директория без создания дериктории
    final filePath = directory.path + '/photo.jpeg';
    final file = File(filePath);
    final bytesPhoto = await photo.readAsBytes();
    final List<int> fileListPhoto = bytesPhoto.cast<int>();

    if (await file.exists()) {
      await deletePhoto(file);
      await writePhoto(file, fileListPhoto);
    }
    else {
      await file.create();
      await writePhoto(file, fileListPhoto);
    }
  }
}

/// Удаление аватарки из памяти устройства
Future<void> deletePhotoFromMemory(File file) async {
  await deletePhoto(file);
}

/// Чтение аватврки из памяти устройства
Future<File?> readPhotoFromMemory() async {
  final directory = await pathProvider.getTemporaryDirectory();
  final filePath = directory.path + '/photo.jpeg';
  final file = File(filePath);
  await readPhoto(file).then(
    (resultPhotoInMemory) async {
      return resultPhotoInMemory;
    },
  );
}
