import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

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
  } catch(e) {
    throw Exception(e);
  }
}

/// Удаление аватарки из памяти устройства
Future<void> deletePhoto(File file) async {
    await file.delete(recursive: true);  // Не полулилось разобраться с удалением(не удаляет)
}

/// Чтение аватарки из помяти устройства
Future<Uint8List> readPhoto(File file) async {
  try {
    final _fileUnit8FromMemory = await file.readAsBytes();
    return _fileUnit8FromMemory;
  }
  catch(e){
    throw Exception('no photo');
  }
}
