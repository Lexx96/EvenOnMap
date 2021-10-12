
import 'dart:async';
import 'dart:convert';
import 'package:event_on_map/news_widget/models/news.dart';
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
  
 void loading() {
   _newsStreamController.sink.add(NewsBlocState.newsLoadingState());

    _newsRepository.getAllNews().then((jsonString) {
      final newsJson = jsonDecode(jsonString) as List<dynamic>;
      final jsonNewsModel = newsJson.map((dynamic json) => News.fromJson(json as Map<String, dynamic>)).toList();

      _newsStreamController.sink.add(NewsBlocState.newsLoadedState(jsonNewsModel));
    });

 }


  void dispose() {
    _newsStreamController.close();
  }

}