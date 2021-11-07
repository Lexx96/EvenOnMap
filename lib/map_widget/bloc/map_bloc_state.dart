
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapBlocState {
  MapBlocState();
  factory MapBlocState.loadingLatLng() = LoadingLatLng;
  factory MapBlocState.loadedLatLngAndAddress( Position position, List<Placemark> placemark) = LoadedLatLng;

}



class LoadingLatLng extends MapBlocState {}

class LoadedLatLng extends MapBlocState {
  Position position;
  List<Placemark> placemark;
  LoadedLatLng(this.position, this.placemark);
}
