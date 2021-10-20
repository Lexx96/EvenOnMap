

import 'dart:io';

import 'package:event_on_map/userProfile/services/user_profile__page_repository.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileProvider {

  Future<File?> getImageFileUserProfile (ImageSource source) async{
    try{
      final _imageXFile = await userProfileImageXFile(source);
      final image = File(_imageXFile!.path);
      return image;
    }
    catch(error){
      print('Ошибка получения изображения от репозитория $error');
    }

  }
}