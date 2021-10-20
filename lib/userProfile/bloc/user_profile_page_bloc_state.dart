
import 'dart:io';

class UserProfileBlocState {
  UserProfileBlocState();
  factory UserProfileBlocState.emptyPickImage() = EmptyUserProfile;
  factory UserProfileBlocState.loadingPickImage() = LoadingUserProfile;
  factory UserProfileBlocState.loadedPickImage(File? image) = LoadedUserProfile;
}

class EmptyUserProfile extends UserProfileBlocState {}

class LoadingUserProfile extends UserProfileBlocState {}

class LoadedUserProfile extends UserProfileBlocState {
  late File? image;
  LoadedUserProfile(this.image);
}
