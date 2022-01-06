import 'package:flutter/material.dart';
import 'package:swivt_assignment/components/custom_app_bar.dart';
import 'package:swivt_assignment/features/news/models/news_model.dart';
import 'package:swivt_assignment/features/news/views/widgets/news_detail_card.dart';

class NewsDetailScreen extends StatelessWidget {
  final List<NewsModel> newsList;
  final int navigatedFromIndex;
  static const String route = '/newsDetailRoute';
  const NewsDetailScreen(
      {Key? key, required this.newsList, required this.navigatedFromIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _controller =
        PageController(initialPage: navigatedFromIndex);
    return Scaffold(
      appBar:
          buildCustomAppBarWithBack(pageTitle: 'News Detail', context: context),
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final _news = newsList[index];
          return NewsDetailCard(
            newsImage: _news.urlToImage ??
                'https://www.gizmohnews.com/assets/images/news.png',
            source:
                _news.source == '' ? 'No source' : _news.source ?? 'No source',
            title: _news.title == '' ? 'No title' : _news.title ?? '',
            content: _news.content == ''
                ? 'No Content Available'
                : _news.content ?? 'No Content Available',
            url: _news.url ?? '',
          );
        },
      ),
    );
  }
}
