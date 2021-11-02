import 'dart:io';
import 'package:flutter/material.dart';
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
Future<File> writePhoto(File file, List<int>? fileListPhoto) async {
  final writeFile = await file.writeAsBytes(fileListPhoto!, mode: FileMode.write, flush: true);
  return writeFile;
}

/// Удаление аватарки из памяти устройства
Future<void> deletePhoto(File file) async {
  await file.delete(recursive: true);
}

/// Чтение аватарки из помяти устройства
Future<Image> readPhoto(File file) async { // не читается файл , сделать проверку в виджите есть ли файл  впамяти если сть вывести его
    final resultPhoto = Image.file(file);
    return resultPhoto;
}
