

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


Future userProfileImageXFile(ImageSource source) async {
  try {
    final image = await ImagePicker().pickImage(source: source);
    if(image == null) return;
    return image;
  } on PlatformException
  catch (error) {
    print('Ошибка выбора картинки $error');
  }
}