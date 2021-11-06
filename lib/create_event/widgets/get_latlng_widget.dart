import 'package:event_on_map/create_event/bloc/create_event/create_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class GetLatLngWidget extends StatefulWidget {
  const GetLatLngWidget({
    Key? key,
    required ServiceNewEventBloc bloc,
  })  : _bloc = bloc,
        super(key: key);

  final ServiceNewEventBloc _bloc;

  @override
  State<GetLatLngWidget> createState() => _GetLatLngWidgetState();
}

class _GetLatLngWidgetState extends State<GetLatLngWidget> {




  @override
  Widget build(BuildContext context) {
    return Container();
  }
}