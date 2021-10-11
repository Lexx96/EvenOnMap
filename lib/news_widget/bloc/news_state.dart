

class NewsBlocState {
  NewsBlocState();

  factory NewsBlocState.newsEmptyState() = NewsEmptyState;
  factory NewsBlocState.newsLoadingState() = NewsLoadingState;
  factory NewsBlocState.newsLoadedState() = NewsLoadedState;

}


class NewsEmptyState extends NewsBlocState {}

class NewsLoadingState extends NewsBlocState {}

class NewsLoadedState extends NewsBlocState {}