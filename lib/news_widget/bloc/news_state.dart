

import 'package:event_on_map/news_widget/models/news.dart';

class NewsBlocState {
  NewsBlocState();

  factory NewsBlocState.newsEmptyState() = NewsEmptyState;
  factory NewsBlocState.newsLoadingState() = NewsLoadingState;
  factory NewsBlocState.newsLoadedState(List<News> news) = NewsLoadedState;

}


class NewsEmptyState extends NewsBlocState {}

class NewsLoadingState extends NewsBlocState {}

class NewsLoadedState extends NewsBlocState {
  final List<News> news;
  NewsLoadedState(this.news);
}