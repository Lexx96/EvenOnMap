
abstract class NewsState {}

class NewsEmptyState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  List<dynamic> loadedNews;
  NewsLoadedState({required this.loadedNews}) : assert(loadedNews != null);  // что за шляпа
}
class NewsClearState extends NewsState {}

class NewsErrorState extends NewsState {}