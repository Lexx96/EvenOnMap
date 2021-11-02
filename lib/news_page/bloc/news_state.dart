



import 'package:event_on_map/news_page/models/news.dart';

class NewsBlocState {
  NewsBlocState();

  factory NewsBlocState.newsEmptyState() = NewsEmptyState;
  factory NewsBlocState.newsLoadingState() = NewsLoadingState;
  factory NewsBlocState.newsLoadedState(List<GetNewsFromServerModel> newsFromServer) = NewsLoadedState;
  factory NewsBlocState.dataErrorSendingServer() = DataErrorSendingServer;
  factory NewsBlocState.notRegisteredSendingServer() = NotRegisteredSendingServer;
}


class NewsEmptyState extends NewsBlocState {}

class NewsLoadingState extends NewsBlocState {}

class NewsLoadedState extends NewsBlocState {
  final List<GetNewsFromServerModel> newsFromServer;
  NewsLoadedState(this.newsFromServer);
}

class DataErrorSendingServer extends NewsBlocState {}

class NotRegisteredSendingServer extends NewsBlocState {}