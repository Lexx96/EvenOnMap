
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'pick_image_repository.dart';

class PickImageProvider {

  Future<File?> getImageFile (ImageSource source) async{
    try{
      final imageXFile = await pickImageXFile(source);
      final image = File(imageXFile!.path);
      return image;
    }
    catch(error){
      print('Ошибка получения изображения от репозитория $error');
    }
  }
}