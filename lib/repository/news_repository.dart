import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';

class NewsRepository{
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String newsChannel) async {
    String newsUrl = 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=cbcf321776ec418783f69ed46b79089a';
    print(newsUrl);
    final response = await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String newsUrl = 'https://newsapi.org/v2/everything?q=${category}&apiKey=cbcf321776ec418783f69ed46b79089a';
    print(newsUrl);
    final response = await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}