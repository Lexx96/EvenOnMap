import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _myLocation = LatLng(53.769997, 87.137535);
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _myLocation,
        zoom: 16,
      ),
    ));
  }
}
