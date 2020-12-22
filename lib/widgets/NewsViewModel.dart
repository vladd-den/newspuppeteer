import 'package:projectest/models/NewArticle.dart';

class NewsArticleViewModel {

  NewsArticle _newsArticle;

  NewsArticleViewModel({NewsArticle article}): _newsArticle = article;

  String get title {
    return _newsArticle.title;
  }

  String get description {
    return _newsArticle.descrption;
  }

  String get imageURL {
    return _newsArticle.urlToImage;
  }

}