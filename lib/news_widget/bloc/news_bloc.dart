import 'dart:async';
import 'package:event_on_map/news_widget/services/news_api_repository.dart';
import 'package:event_on_map/news_widget/services/news_provider.dart';
import 'news_state.dart';

class ServiceNewsBloc {
  final NewsRepository _newsRepository;

  ServiceNewsBloc(this._newsRepository);

  final _newsStreamController = StreamController<NewsBlocState>();

  Stream<NewsBlocState> get newsStreamController =>
      _newsStreamController.stream;

  void emptyState() {
    _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
  }

  void loading()  {
    _newsStreamController.sink.add(NewsBlocState.newsLoadingState());
    try {
       NewsProvider().getAllNews().then(
        (jsonNewsModel) {
          if (jsonNewsModel.isNotEmpty) {
            _newsStreamController.sink
                .add(NewsBlocState.newsLoadedState(jsonNewsModel));
          }
          else {
            _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
          }
        },
      );
    } catch (errorBloc) {
      _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
      print('Ошибка запроса новостей $errorBloc');
    }
  }

  Future <void> onRefresh() async{
      try{
        NewsProvider().getAllNews().then(
              (jsonNewsModel) {
            if (jsonNewsModel.isNotEmpty) {
              _newsStreamController.sink
                  .add(NewsBlocState.newsLoadedState(jsonNewsModel));
            }
            else {
              loading();
            }
          },
        );
      }
      catch(errorOnRefresh){
        loading();
        print('Ошибка запроса новостей $errorOnRefresh');
      }
  }

  Future <void> onLoading() async{
    try{
      NewsProvider().getAllNews().then(
            (jsonNewsModel) {
          if (jsonNewsModel.isNotEmpty) {
            _newsStreamController.sink
                .add(NewsBlocState.newsLoadedState(jsonNewsModel));
          }
          else {
            loading();
          }
        },
      );
    }
    catch(errorOnRefresh){
      loading();
      print('Ошибка запроса новостей $errorOnRefresh');
    }
  }

  void dispose() {
    _newsStreamController.close();
  }
}
