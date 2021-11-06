
import 'dart:io';

class UserProfileImageBlocState {
  UserProfileImageBlocState();
  factory UserProfileImageBlocState.emptyPickImage() = EmptyImageUserProfile;
  factory UserProfileImageBlocState.loadingPickImage() = LoadingImageUserProfile;
  factory UserProfileImageBlocState.loadedPickImage(File? image) = LoadedImageUserProfile;
  factory UserProfileImageBlocState.loadedImageUserForDrawer(File? image) = LoadedImageUserForDrawer;
  factory UserProfileImageBlocState.emptyImageDrawer() = EmptyImageDrawer;
}

class EmptyImageUserProfile extends UserProfileImageBlocState {}

class LoadingImageUserProfile extends UserProfileImageBlocState {}

class LoadedImageUserProfile extends UserProfileImageBlocState {
  late File? image;
  LoadedImageUserProfile(this.image);
}

class LoadedImageUserForDrawer extends UserProfileImageBlocState {
  late File? image;
  LoadedImageUserForDrawer(this.image);
}

class EmptyImageDrawer extends UserProfileImageBlocState {}
