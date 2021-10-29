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

  /// Получение новостей с сервера
  void loadingNewsFromServer() {
    _newsStreamController.sink.add(NewsBlocState.newsLoadingState());
    NewsProvider().getAllNewsFromServer().then(
      (jsonNewsModel) {
        _newsStreamController.sink
            .add(NewsBlocState.newsLoadedState(jsonNewsModel));
      },
    ).catchError(
      (exception) {
        if (exception is DataErrorSendingServerException) {
          _newsStreamController.sink
              .add(NewsBlocState.dataErrorSendingServer());
        } else if (exception is NotRegisteredSendingServerException) {
          _newsStreamController.sink
              .add(NewsBlocState.notRegisteredSendingServer());
        } else {
          _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
        }
      },
    );
  }

  /// Обновление новостной ленты in Top
  Future<void> onRefresh() async {
    NewsProvider().getAllNewsFromServer().then(
      (jsonNewsModel) {
        _newsStreamController.sink
            .add(NewsBlocState.newsLoadedState(jsonNewsModel));
        loadingNewsFromServer();
      },
    ).catchError(
      (exception) {
        if (exception is DataErrorSendingServerException) {
          _newsStreamController.sink
              .add(NewsBlocState.dataErrorSendingServer());
        } else if (exception is NotRegisteredSendingServerException) {
          _newsStreamController.sink
              .add(NewsBlocState.notRegisteredSendingServer());
        } else {
          _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
        }
      },
    );
  }

  /// Обновление новостной ленты in Bottom
  Future<void> onLoading() async {
    NewsProvider().getAllNewsFromServer().then(
      (jsonNewsModel) {
        _newsStreamController.sink
            .add(NewsBlocState.newsLoadedState(jsonNewsModel));
        loadingNewsFromServer();
      },
    ).catchError(
      (exception) {
        if (exception is DataErrorSendingServerException) {
          _newsStreamController.sink
              .add(NewsBlocState.dataErrorSendingServer());
        } else if (exception is NotRegisteredSendingServerException) {
          _newsStreamController.sink
              .add(NewsBlocState.notRegisteredSendingServer());
        } else {
          _newsStreamController.sink.add(NewsBlocState.newsEmptyState());
        }
      },
    );
  }

  void dispose() {
    _newsStreamController.close();
  }
}

class DataErrorSendingServerException implements Exception {}

class NotRegisteredSendingServerException implements Exception {}
