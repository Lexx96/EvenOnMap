import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddingImagesWidget extends StatefulWidget {
  const AddingImagesWidget({Key? key}) : super(key: key);

  @override
  State<AddingImagesWidget> createState() => _AddingImagesWidgetState();
}

class _AddingImagesWidgetState extends State<AddingImagesWidget> {
  File? image;
  File? imageTwo;
  File? imageThree;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException // что то типо автоматического выбора виджета в замисимости от платформв
    catch (error) {
      print('Ошибка выбора картинки $error');
    }
  }

  Future pickImageTwo(ImageSource source) async {
    try {
      final imageTwo =
          await ImagePicker().pickImage(source: source);
      if (imageTwo == null) return;

      final imageTwoTemporary = File(imageTwo.path);
      setState(() => this.imageTwo = imageTwoTemporary);
    } on PlatformException // что то типо автоматического выбора виджета в замисимости от платформв
    catch (error) {
      print('Ошибка выбора картинки $error');
    }
  }

  Future pickImageFree(ImageSource source) async {
    try {
      final imageFree =
          await ImagePicker().pickImage(source: source);
      if (imageFree == null) return;

      final imageFreeTemporary = File(imageFree.path);
      setState(() => this.imageThree = imageFreeTemporary);
    } on PlatformException // что то типо автоматического выбора виджета в замисимости от платформв
    catch (error) {
      print('Ошибка выбора картинки $error');
    }
  }

  Widget plusImage() {
    if (image != null) {
      return Container(
          width: 100,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: InkWell(
              onTap: () {
                print('e');
              },
              child: Stack(
                children: [
                  Center(
                    child: Image.file(image!),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextButton(
          onPressed: () => showImagesSource(context),
          child: Icon(
            Icons.add_rounded,
            size: 45,
            color: Colors.grey,
          ),
        ),
      );
    }
  }

  Widget plusImageTwo() {
    if (imageTwo != null) {
      return Container(
          width: 100,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: InkWell(
              onTap: () {
                print('e');
              },
              child: Stack(
                children: [
                  Center(
                    child: Image.file(imageTwo!),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextButton(
          onPressed: () => showImagesSource(context),
          child: Icon(
            Icons.add_rounded,
            size: 45,
            color: Colors.grey,
          ),
        ),
      );
    }
  }

  Widget plusImageFree() {
    if (imageThree != null) {
      return Container(
          width: 100,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: InkWell(
              onTap: () {
                print('e');
              },
              child: Stack(
                children: [
                  Center(
                    child: Image.file(imageThree!),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: TextButton(
          onPressed: () => showImagesSource(context),
          child: Icon(
            Icons.add_rounded,
            size: 45,
            color: Colors.grey,
          ),
        ),
      );
    }
  }

  Widget allImages() {
    if (image == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          plusImage(),
        ],
      );
    } else if (image != null && imageTwo == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          plusImage(),
          SizedBox(
            width: 10,
          ),
          plusImageTwo(),
        ],
      );
    } else if (image != null && imageTwo != null && imageThree == null ||
        imageThree != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          plusImage(),
          SizedBox(
            width: 10,
          ),
          plusImageTwo(),
          SizedBox(
            width: 10,
          ),
          plusImageFree(),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {}, //pickImage(),
          child: Icon(
            Icons.add_rounded,
            size: 45,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Future<ImageSource?> showImagesSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                if (image == null){
                  pickImage(ImageSource.camera);
                }
                else if (image != null && imageTwo == null){
                  pickImageTwo(ImageSource.camera);
                }
                else if (image != null && imageTwo != null && imageThree == null ||
                    imageThree != null){
                  pickImageFree(ImageSource.camera);
                }
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(Icons.camera_alt), Text('Камера')],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                if (image == null){
                  pickImage(ImageSource.camera);
                }
                else if (image != null && imageTwo == null){
                  pickImageTwo(ImageSource.camera);
                }
                else if (image != null && imageTwo != null && imageThree == null ||
                    imageThree != null){
                  pickImageFree(ImageSource.camera);
                }
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Icon(Icons.photo), Text('Галерея')],
              ),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Камера'),
              onTap: () {
                if (image == null){
                  pickImage(ImageSource.camera);
                }
                else if (image != null && imageTwo == null){
                  pickImageTwo(ImageSource.camera);
                }
                else if (image != null && imageTwo != null && imageThree == null ||
                    imageThree != null){
                  pickImageFree(ImageSource.camera);
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Галерея'),
              onTap: () {
                if (image == null){
                  pickImage(ImageSource.gallery);
                }
                else if (image != null && imageTwo == null){
                  pickImageTwo(ImageSource.gallery);
                }
                else if (image != null && imageTwo != null && imageThree == null ||
                    imageThree != null){
                  pickImageFree(ImageSource.gallery);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  // как сделать замену и удаление
  // Future<ImageSource?> showOptionsForChangingImage(BuildContext context) async {
  //   if (Platform.isIOS) {
  //     return showCupertinoModalPopup<ImageSource>(
  //       context: context,
  //       builder: (context) => CupertinoActionSheet(
  //         actions: [
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               showImagesSource(context);
  //               Navigator.of(context).pop();
  //               },
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [Icon(Icons.edit), Text('Заменить')],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return showModalBottomSheet(
  //       context: context,
  //       builder: (context) => Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ListTile(
  //             leading: Icon(Icons.camera_alt),
  //             title: Text('Камера'),
  //             onTap: () {
  //               if (image == null){
  //                 pickImage(ImageSource.camera);
  //               }
  //               else if (image != null && imageTwo == null){
  //                 pickImageTwo(ImageSource.camera);
  //               }
  //               else if (image != null && imageTwo != null && imageFree == null ||
  //                   imageFree != null){
  //                 pickImageFree(ImageSource.camera);
  //               }
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.photo),
  //             title: Text('Галерея'),
  //             onTap: () {
  //               if (image == null){
  //                 pickImage(ImageSource.gallery);
  //               }
  //               else if (image != null && imageTwo == null){
  //                 pickImageTwo(ImageSource.gallery);
  //               }
  //               else if (image != null && imageTwo != null && imageFree == null ||
  //                   imageFree != null){
  //                 pickImageFree(ImageSource.gallery);
  //               }
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [allImages()],
        ),
      ),
    );
  }
}
