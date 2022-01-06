import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swivt_assignment/app/exceptions/app_exceptions.dart';
import 'package:swivt_assignment/features/news/models/news_model.dart';
import 'package:swivt_assignment/features/news/services/news_services.dart';
import 'package:swivt_assignment/utils/app_logger.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;
  int page = 2;

  NewsBloc({required this.newsService}) : super(NewsInitial()) {
    on<GetNewsEvent>(_handleGetNewsEvent);
    on<LoadMoreNewsEvent>(_handleLoadMoreNewsEvent);
  }

  _handleGetNewsEvent(GetNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final result = await newsService.getNewsDetails(page: 1);
      if (result != null) {
        emit(NewsLoadSuccess(newsList: result));
      } else {
        emit(NewsLoadFailure(errorMessage: 'Data could not be loaded'));
      }
    } on RateLimitException {
      emit(NewsLoadFailure(errorMessage: 'Woah! go slow. Please wait now!'));
    } catch (e) {
      emit(NewsLoadFailure(errorMessage: 'Unknown error occured'));
    }
  }

  _handleLoadMoreNewsEvent(
      LoadMoreNewsEvent event, Emitter<NewsState> emit) async {
    try {
      if (state is NewsLoadSuccess) {
        final currentNewsList = state as NewsLoadSuccess;
        final result = await newsService.getNewsDetails(page: page);
        if (result != null) {
          emit(NewsLoadSuccess(
              newsList: [...currentNewsList.newsList, ...result]));
          page++;
        } else {
          emit(NewsLoadFailure(errorMessage: 'Data could not be loaded.'));
        }
      }
    } on RateLimitException {
      emit(NewsLoadFailure(errorMessage: 'Woah! go slow. Please wait now!'));
    } catch (e) {
      AppLogger.error(e.toString());
      emit(NewsLoadFailure(errorMessage: 'Unknown error occured'));
    }
  }
}
