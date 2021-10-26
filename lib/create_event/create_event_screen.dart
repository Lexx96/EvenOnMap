import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons_icons.dart';
import 'widgets/images_widget.dart';
import 'bloc/create_event/create_event_bloc_state.dart';
import 'bloc/create_event/create_event_bloc.dart';
import 'widgets/form_widget.dart';

class CreateEventWidget extends StatefulWidget {
  const CreateEventWidget({Key? key}) : super(key: key);

  @override
  _CreateEventWidgetState createState() => _CreateEventWidgetState();
}

class _CreateEventWidgetState extends State<CreateEventWidget> {
  late ServiceNewEventBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceNewEventBloc();
    _bloc.emptyEventBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: _bloc.streamEventController,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is EventEmptyBloc ||
                  snapshot.data is EventLoadingBloc) {
                return Stack(
                  children: [
                    ListView(
                      children: [
                        FormWidget(),
                        ImagesWidget(),
                        GetLatLngWidget(bloc: _bloc),
                      ],
                    ),
                    snapshot.data is EventLoadingBloc
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox.shrink(),
                  ],
                );
              }
              if (snapshot.data is GetLatLng) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(53.769997, 87.137535),
                    zoom: 16,
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class GetLatLngWidget extends StatelessWidget {
  const GetLatLngWidget({
    Key? key,
    required ServiceNewEventBloc bloc,
  }) : _bloc = bloc, super(key: key);

  final ServiceNewEventBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Укажите место',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () => _bloc.getLatLngOnMap(),
              child: Icon(
                CustomIcons.location,
                color: Colors.blue,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Colors.transparent),
                overlayColor:
                    MaterialStateProperty.all(Colors.grey),
                elevation: MaterialStateProperty.all(0),
                minimumSize:
                    MaterialStateProperty.all(Size(60, 30)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
