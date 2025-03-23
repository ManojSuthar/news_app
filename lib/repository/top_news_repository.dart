import 'package:newsapi_sample/models/news_model_entity.dart';

abstract class TopNewsRepository {
  Future<List<NewsModelEntity>> fetchTopHeadlines(int page, int pageSize);
}
