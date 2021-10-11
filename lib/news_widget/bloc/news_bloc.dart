

import 'dart:async';

import 'package:event_on_map/news_widget/services/news_repository.dart';

import 'news_state.dart';

class ServiceNewsBloc {

  final NewsRepository _newsRepository;
  ServiceNewsBloc(this._newsRepository);




  final _newsStreamController = StreamController<NewsBlocState>();

  Stream<NewsBlocState> get newsStreamController => _newsStreamController.stream;

  void emptyState () {
    _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
  }





  void dispose() {
    _newsStreamController.close();
  }

}