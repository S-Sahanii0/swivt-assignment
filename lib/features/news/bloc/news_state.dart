part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoadSuccess extends NewsState {
  final List<NewsModel> newsList;

  NewsLoadSuccess({required this.newsList});

  @override
  List<Object?> get props => newsList;
}

class NewsLoadFailure extends NewsState {}
