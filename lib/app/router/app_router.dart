import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swivt_assignment/features/news/bloc/news_bloc.dart';
import 'package:swivt_assignment/features/news/services/news_services.dart';
import 'package:swivt_assignment/features/news/views/news_screen.dart';

//services instances
final _newsService = NewsService();

//bloc instances
final _newsBloc = NewsBloc(newsService: _newsService);

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NewsScreen.route:
      return MaterialPageRoute(builder: (context) => NewsScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => BlocProvider<NewsBloc>.value(
                value: _newsBloc,
                child: const NewsScreen(),
              ));
  }
}
