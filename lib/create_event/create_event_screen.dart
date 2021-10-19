
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../custom_icons.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.streamEventController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data is EventEmptyBloc) {
            return ListView(
              children: [
                FormWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(child: Text('Добавить фото'),),
                ),
                SizedBox(height: 10,),
                ImagesWidget(),
                Padding(
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
                            backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
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
                ),
              ],
            );
          }
          if(snapshot.data is GetLatLng) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(53.769997, 87.137535),
                zoom: 16,
              ),
            );
          }
          if(snapshot.data is EventLoadingBloc) {
            return Stack(
              children: [
                ListView(
                  children: [
                    FormWidget(),
                    Center(child: Text('Добавить фото'),),
                    SizedBox(height: 10,),
                    ImagesWidget(),
                    Padding(
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
                                backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
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
                    ),
                  ],
                ),
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          if(snapshot.data is EventLoadedBloc) {}
          return Center(child: CircularProgressIndicator());
        }
      )
    );
  }
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}




