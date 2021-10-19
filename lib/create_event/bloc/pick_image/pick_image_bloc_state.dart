

import 'dart:io';


class PickImageBlocState {
  PickImageBlocState();
  factory PickImageBlocState.emptyPickImage() = EmptyPickImage;
  factory PickImageBlocState.loadingPickImage() = LoadingPickImage;
  factory PickImageBlocState.loadedPickImage(File? image) = LoadedPickImage;
}

class EmptyPickImage extends PickImageBlocState {}

class LoadingPickImage extends PickImageBlocState {}

class LoadedPickImage extends PickImageBlocState {
  late File? image;
  LoadedPickImage(this.image);
}




