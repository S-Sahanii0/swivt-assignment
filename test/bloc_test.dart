import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:mocktail/mocktail.dart';

import 'package:swivt_assignment/features/news/bloc/news_bloc.dart';
import 'package:swivt_assignment/features/news/models/news_model.dart';
import 'package:swivt_assignment/features/news/services/news_services.dart';

class MockUserRepository extends Mock implements NewsService {}

void main() {
  late MockUserRepository mockNewsService;

  blocTest(
    'emits [NewsLoading , NewsLoadSuccess] states for successful news loads',
    setUp: () {
      EquatableConfig.stringify =
          true; //to make bloc state and parameters pretty
      mockNewsService = MockUserRepository();
      when(() => mockNewsService.getNewsDetails()).thenAnswer((_) async => ([
            NewsModel(
                source: 'test',
                author: 'test',
                description: 'test',
                title: 'test')
          ]));
    },
    build: () {
      return NewsBloc(newsService: mockNewsService);
    },
    act: (NewsBloc bloc) => bloc.add(GetNewsEvent()),
    expect: () {
      return [
        NewsLoading(),
        NewsLoadSuccess(newsList: [
          NewsModel(
              source: 'test',
              author: 'test',
              description: 'test',
              title: 'test')
        ])
      ];
    },
  );
}
