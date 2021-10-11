/*
Создаем папку models
                 news - модель нашей новости распарсенная с json

Создаем (api) папку services
                 provider - поставщик не обработанных данных
                 repository - хранилище

Создаем папку bloc
                 news_event - описываем какие могут быть события
                 news_state - описываем какие могут быть состояния
                 news_bloc - прописываем что делать в случае чего

в Виджете :
                 Оборачиваем Scaffold в
                 BlocProvider<NewsBloc>(
                 // инициализируем bloc используя BlocProvider <NewsBloc>
                 create: (context) => NewsBloc(newsRepository: newsRepository),

                 в дереве виджетов оборачиваем вержний виджет в
                 BlocBuilder<NewsBloc, NewsState>
                  (builder: (context, state) {
                  if(){}
                  if(){}

                  и в случае ошибки
                  return что то например надпись или CircularProgressIndicator
                  }

                  в виджете если нужно обратиться к BLoC :
                  final NewsBloc _newsBloc = BlocProvider.of<NewsBloc>(context);


 */