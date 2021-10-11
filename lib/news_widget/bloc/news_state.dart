
abstract class NewsState {}

class NewsEmptyState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  List <dynamic> loadedNews;
  NewsLoadedState({required this.loadedNews});
}
class NewsClearState extends NewsState {}

class NewsErrorState extends NewsState {}