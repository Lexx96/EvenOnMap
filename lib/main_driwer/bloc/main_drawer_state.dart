
import 'dart:io';

class MainDrawerBlocState {
  MainDrawerBlocState();
  factory MainDrawerBlocState.getUserDataFromSharedPreferencesMainDrawerState(Map<String, String?> userData) = GetUserDataFromSharedPreferencesMainDrawerState;
  factory MainDrawerBlocState.emptyMainDrawerState() = EmptyMainDrawerState;
  factory MainDrawerBlocState.loadingImageMainDrawerState() = LoadingImageMainDrawerState;
  factory MainDrawerBlocState.showMessageState() = ShowMessageState;
  factory MainDrawerBlocState.closeAlertDialogState() = CloseAlertDialogState;
  factory MainDrawerBlocState.loadedImageUserProfileForDrawerState(File? image) = LoadedImageUserProfileForDrawerState;

}

class GetUserDataFromSharedPreferencesMainDrawerState extends MainDrawerBlocState {
  Map<String, String?> userData;
  GetUserDataFromSharedPreferencesMainDrawerState(this.userData);
}

class EmptyMainDrawerState extends MainDrawerBlocState {}

class LoadingImageMainDrawerState extends MainDrawerBlocState {}

class ShowMessageState extends MainDrawerBlocState {}

class CloseAlertDialogState extends MainDrawerBlocState {}

class LoadedImageUserProfileForDrawerState extends MainDrawerBlocState {
  late File? image;
  LoadedImageUserProfileForDrawerState(this.image);
}