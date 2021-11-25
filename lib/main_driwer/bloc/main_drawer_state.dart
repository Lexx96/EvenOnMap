
import 'dart:io';

class MainDrawerBlocState {
  MainDrawerBlocState();
  factory MainDrawerBlocState.emptyMainDrawerState() = EmptyMainDrawerState;
  factory MainDrawerBlocState.showMessageState() = ShowMessageState;
  factory MainDrawerBlocState.closeAlertDialogState() = CloseAlertDialogState;
  factory MainDrawerBlocState.loadedImageUserProfileForDrawer(File? image) = LoadedImageUserProfileForDrawerState;

}

class EmptyMainDrawerState extends MainDrawerBlocState {}

class ShowMessageState extends MainDrawerBlocState {}

class CloseAlertDialogState extends MainDrawerBlocState {}

class LoadedImageUserProfileForDrawerState extends MainDrawerBlocState {
  late File? image;
  LoadedImageUserProfileForDrawerState(this.image);
}