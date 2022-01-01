

import 'dart:async';

import 'decoration_page_bloc_state.dart';

class DecorationPageBloc {

  final _streamController = StreamController<DecorationPageState>();

  Stream<DecorationPageState> get streamController => _streamController.stream;

  void emptyThemeState () {
    _streamController.sink.add(DecorationPageState.emptyDecorationPageState());
  }

  void systemThemeState () {
    _streamController.sink.add(DecorationPageState.systemThemeDecorationPageState());
  }

  void lightThemeState () {
    _streamController.sink.add(DecorationPageState.lightThemeDecorationPageState());
  }

  void darkThemeState () {
    _streamController.sink.add(DecorationPageState.darkThemeDecorationPageState());
  }

  void dispose() {
    _streamController.close();
  }
}