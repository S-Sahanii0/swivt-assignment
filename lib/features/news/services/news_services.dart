import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swivt_assignment/features/news/models/news_model.dart';
import 'package:swivt_assignment/app/network/api_client.dart';

class NewsService {
  final _apiClient = ApiClient();

  Future<List<NewsModel>?> getNewsDetails() async {
    try {
      final data = await _apiClient.get(
          //only displaying business news
          'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${dotenv.env['api_key']}');
      final listOfNews = data['articles'] as List;
      return listOfNews.map((e) => NewsModel.fromJson(json.encode(e))).toList();
    } catch (e) {
      return null;
    }
  }
}
