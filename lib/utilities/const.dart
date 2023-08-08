class Const {
  static const apiKey = 'c18e57c04436432ea23c560a71cf88d7';
  static const String topNews =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
  static String topNewsbyCategory(String category) {
    return 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey';
  }

  static const Map<String, String> categories = {
    'General': 'general',
    'Entertainment': 'entertainment',
    'Business': 'business',
    'Sports': 'sports',
    'Technology': 'technology',
    'Science': 'science',
    'Health': 'health'
  };
}
