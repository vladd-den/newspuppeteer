import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:projectest/models/NewArticle.dart';
import 'package:projectest/utils/constants.dart';
import 'dart:convert';

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class Webservice {
  Future<List<NewsArticle>> fetchTopHeadlines() async {

    final response = await http.get(Constants.HEADLINE_NEWS_URL);

    if(response.statusCode == 200) {

      final result = jsonDecode(response.body);
      Iterable list = result["articles"];
      return list.map((article) => NewsArticle.fromJson(article)).toList();

    } else {
      throw Exception("Failed to get top news");
    }

  }

  Future<List<NewsArticle>> fetchHeadlinesByKeyword(String keyword) async{
    final response = await http.get(Constants.headlinesFor(keyword));

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["articles"];
      return list.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get news");
    }
  }

  Future<T> load<T>(Resource<T> resource) async {

    final response = await http.get(resource.url);
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

}