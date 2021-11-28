
import 'dart:io';

class UserProfileImageBlocState {
  UserProfileImageBlocState();
  factory UserProfileImageBlocState.emptyPickImage() = EmptyImageUserProfile;
  factory UserProfileImageBlocState.getUserDataInSharedPreferencesState(Map<String, String?> userData) = GetUserDataFromSharedPreferencesState;
  factory UserProfileImageBlocState.loadingPickImage() = LoadingImageUserProfile;
  factory UserProfileImageBlocState.loadedPickImage(File? image) = LoadedImageUserProfile;
  factory UserProfileImageBlocState.loadedImageUserForDrawer(File? image) = LoadedImageUserForDrawer;
  factory UserProfileImageBlocState.emptyImageDrawer() = EmptyImageDrawer;
}

class EmptyImageUserProfile extends UserProfileImageBlocState {}

class GetUserDataFromSharedPreferencesState extends UserProfileImageBlocState {
  Map<String, String?> userData;
  GetUserDataFromSharedPreferencesState(this.userData);
}

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
