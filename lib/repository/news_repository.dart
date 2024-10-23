import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_channels_headlines_model.dart';

class NewsRepository{
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async{
    String baseUrl = dotenv.get('url', fallback: 'google.com');

    final response =  await http.get(Uri.parse(baseUrl));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }
}