class Constants {

  static final String HEADLINE_NEWS_URL = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=5db590392fe04958a0b8579b83c0e7ca';

  static String headlinesFor(String keyword) {

    return  "https://newsapi.org/v2/everything?q=$keyword&apiKey=5db590392fe04958a0b8579b83c0e7ca";

  }

  static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/placeholder.png';

}