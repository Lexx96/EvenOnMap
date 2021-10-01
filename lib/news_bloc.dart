// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// enum MoreDetailedOnTab { tab_more_details }
//
// class MoreDetailsBloc{
//   dynamic _maxLines = 3;
//   final _inputEventController = StreamController<MoreDetailedOnTab>();
//   StreamSink<MoreDetailedOnTab> get inputEventSink => _inputEventController.sink;
//
//   final _outputStreamController = StreamController<dynamic>();
//   Stream<dynamic> get outputStateStream => _outputStreamController.stream;
//
//    void _moreDetailedState(MoreDetailedOnTab event){
//     if(event == MoreDetailedOnTab.tab_more_details)
//       _maxLines = null;
//     else throw Exception('Error State');
//
//     _outputStreamController.sink.add(_maxLines);
//   }
//
//   MoreDetailsBloc(){
//     _inputEventController.stream.listen(_moreDetailedState);
//   }
//
//   void dispose (){
//     _inputEventController.close();
//     _outputStreamController.close();
//   }
// }