import 'package:newsapi_sample/repository/top_news_repository.dart';
import 'package:newsapi_sample/services/api_service.dart';

import '../models/news_model_entity.dart';

class TopNewsRepositoryImp implements TopNewsRepository {
  final ApiService _apiService;
  TopNewsRepositoryImp(this._apiService);

  @override
  Future<List<NewsModelEntity>> fetchTopHeadlines(
    int page,
    int pageSize,
  ) async {
    try {
      return await _apiService.fetchTopHeadlines(page, pageSize);
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }
}
