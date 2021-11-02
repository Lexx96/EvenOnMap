
import 'dart:async';

import 'main_drawer_state.dart';

class MainDrawerBloc {

  final _streamController = StreamController<MainDrawerBlocState>();

  Stream<MainDrawerBlocState> get streamController => _streamController.stream;

  void emptyMainDrawerState () {
    _streamController.sink.add(MainDrawerBlocState.emptyMainDrawerState());
  }

  void dispose () {
    _streamController.close();
  }
}