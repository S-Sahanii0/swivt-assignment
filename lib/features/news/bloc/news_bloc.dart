import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swivt_assignment/features/news/models/news_model.dart';
import 'package:swivt_assignment/features/news/services/news_services.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;

  NewsBloc({required this.newsService}) : super(NewsInitial()) {
    on<GetNewsEvent>(_handleGetNewsEvent);
  }

  _handleGetNewsEvent(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    final result = await newsService.getNewsDetails();
    if (result != null) {
      emit(NewsLoadSuccess(newsList: result));
    } else {
      emit(NewsLoadFailure());
    }
  }
}
