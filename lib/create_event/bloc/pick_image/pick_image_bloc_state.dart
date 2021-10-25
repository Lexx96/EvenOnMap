
import 'dart:io';

class PickImageBlocState {
  PickImageBlocState();
  factory PickImageBlocState.loadingPickImage() = LoadingPickImage;
  factory PickImageBlocState.loadedPickImage(File? image) = LoadedPickImage;
  factory PickImageBlocState.notSelectedPickImage() = NotSelectedPickImage;
}


class LoadingPickImage extends PickImageBlocState {}

class LoadedPickImage extends PickImageBlocState {
  late File? image;
  LoadedPickImage(this.image);
}

class NotSelectedPickImage extends PickImageBlocState {}




