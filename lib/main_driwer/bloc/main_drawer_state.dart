
import 'dart:io';

class MainDrawerBlocState {
  MainDrawerBlocState();
  factory MainDrawerBlocState.emptyMainDrawerState() = EmptyMainDrawerState;
  factory MainDrawerBlocState.loadedImageUserProfileForDrawer(File? image) = LoadedImageUserProfileForDrawer;

}

class EmptyMainDrawerState extends MainDrawerBlocState {}

class LoadedImageUserProfileForDrawer extends MainDrawerBlocState {
  late File? image;
  LoadedImageUserProfileForDrawer(this.image);
}