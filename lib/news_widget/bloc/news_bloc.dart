import 'package:event_on_map/news_widget/bloc/news_event.dart';
import 'package:event_on_map/news_widget/bloc/news_state.dart';
import 'package:event_on_map/news_widget/models/news.dart';
import 'package:event_on_map/news_widget/services/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class NewsBloc extends Bloc<NewsEvent,NewsState>{
  final NewsRepository newsRepository;  // в конструктор класса принимаеи инстанс репозитория с его помощью будем получать пользователей
  NewsBloc({required this.newsRepository}) : super(NewsLoadingState()); // и говорим, что первоначальное состояние при загрузке страницы NewsLoadingState

  Stream<NewsState> mapEventToState(NewsEvent event) async*{
    if(event is NewsLoadEvent){   // если новости загруженны ???
      yield NewsLoadingState();    // загрудаем новости ???
      try{                          // в try catch будем ловить момент когда новости будут загруженны
        final List<News> _loadedNewsList = await newsRepository.getAllNews();  // нужен репозиторий, что бы загрузить новости
        yield NewsLoadedState(loadedNews: _loadedNewsList);
      }catch(_){
        NewsEmptyState();
      }
    }
    else if(event is NewsClearState) {
      yield NewsEmptyState();
    }
  }
}