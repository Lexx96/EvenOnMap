
import 'dart:io';

class UserProfileImageBlocState {
  UserProfileImageBlocState();
  factory UserProfileImageBlocState.emptyPickImage() = EmptyImageUserProfile;
  factory UserProfileImageBlocState.loadingPickImage() = LoadingImageUserProfile;
  factory UserProfileImageBlocState.loadedPickImage(File? image) = LoadedImageUserProfile;
  factory UserProfileImageBlocState.loadedImageUserProfileForDrawer(File? image) = LoadedImageUserProfileForDrawer;
}

class EmptyImageUserProfile extends UserProfileImageBlocState {}

class LoadingImageUserProfile extends UserProfileImageBlocState {}

class LoadedImageUserProfile extends UserProfileImageBlocState {
  late File? image;
  LoadedImageUserProfile(this.image);
}

class LoadedImageUserProfileForDrawer extends UserProfileImageBlocState {
  late File? image;
  LoadedImageUserProfileForDrawer(this.image);
}