import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api/models/generalmodel.dart';
import 'package:news_api/models/newschannelheadlines.dart';

class newsreposity {
  Future<newsmodel> fetchNewsReposity(String channelname) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=${channelname}&apiKey=c6524fdbb3604e4b8661057303136507";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return newsmodel.fromJson(body);
    }
    throw Exception("ERROR");
  }
  Future<generalcategory> fetchgeneralcategory(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=c6524fdbb3604e4b8661057303136507";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return generalcategory.fromJson(body);
    }
    throw Exception("ERROR");
  }
}
