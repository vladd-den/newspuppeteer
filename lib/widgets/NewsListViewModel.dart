import 'package:flutter/cupertino.dart';
import 'package:projectest/models/NewArticle.dart';
import 'package:projectest/services/WebService.dart';

import 'NewsViewModel.dart';
enum LoadingStatus {
  completed,
  searching,
  empty
}

class NewsArticleListViewModel extends ChangeNotifier {
  var loadingStatus = LoadingStatus.searching;



  List<NewsArticleViewModel> articles = List<NewsArticleViewModel>();

  Future<void> search(String keyword) async {


    notifyListeners();
    List<NewsArticle> newsArticles = await Webservice().fetchHeadlinesByKeyword(
        keyword);
    this.articles =
        newsArticles.map((article) => NewsArticleViewModel(article: article))
            .toList();
    notifyListeners();
  }

  Future<void> populateTopHeadlines() async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<NewsArticle> newsArticles = await Webservice().fetchTopHeadlines();
    this.articles = newsArticles.map((article) => NewsArticleViewModel(article: article)).toList();
    this.loadingStatus = this.articles.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }
}