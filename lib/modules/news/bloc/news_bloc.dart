import 'dart:async';
import 'package:event_on_map/modules/news/services/news_service.dart';
import 'news_state.dart';

/// Класс управления состоянием модуля news
class ServiceNewsBloc {
  final _newsStreamController = StreamController<NewsBlocState>();
  Stream<NewsBlocState> get newsStreamController =>
      _newsStreamController.stream;

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

  /// Обновление новостной ленты свайпом in top
  Future<void> onRefresh() async {
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

  /// Обновление новостной ленты свайпом in bottom
  Future<void> onLoading() async {
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

  void dispose() {
    _newsStreamController.close();
  }
}
/// Классы исключений
class DataErrorSendingServerException implements Exception {}

class NotRegisteredSendingServerException implements Exception {}
