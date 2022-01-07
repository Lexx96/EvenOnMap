import 'package:event_on_map/modules/news/models/news.dart';

/// Состояния модуля news
class NewsBlocState {
  NewsBlocState();
  factory NewsBlocState.newsEmptyState() = NewsEmptyState;
  factory NewsBlocState.newsLoadingState() = NewsLoadingState;
  factory NewsBlocState.newsLoadedState(List<GetNewsFromServerModel> newsFromServer) = NewsLoadedState;
  factory NewsBlocState.dataErrorSendingServer() = DataErrorSendingServer;
  factory NewsBlocState.notRegisteredSendingServer() = NotRegisteredSendingServer;
}


class NewsEmptyState extends NewsBlocState {}

/// Состояние загрузки новостей
class NewsLoadingState extends NewsBlocState {}

/// Состояние загруженных новостей
class NewsLoadedState extends NewsBlocState {
  final List<GetNewsFromServerModel> newsFromServer;
  NewsLoadedState(this.newsFromServer);
}

/// Состояние при получении ошибки от сервера
class DataErrorSendingServer extends NewsBlocState {}

/// Состояние при получении ошибки от сервера
class NotRegisteredSendingServer extends NewsBlocState {}