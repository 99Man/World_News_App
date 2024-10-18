import 'package:news_api/models/generalmodel.dart';
import 'package:news_api/models/newschannelheadlines.dart';
import 'package:news_api/repository/news_channel_repositry.dart';

class NewsView {
  final _rep = newsreposity();
  Future<newsmodel> fetchNewsReposity(String channelname) async {
    final response =await _rep.fetchNewsReposity(channelname);
    return response;
  }
  Future<generalcategory> fetchgeneralcategory(String category) async {
    final response =await _rep.fetchgeneralcategory(category);
    return response;
  }
}
