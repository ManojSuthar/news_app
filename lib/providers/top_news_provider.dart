import 'package:flutter/cupertino.dart';
import 'package:newsapi_sample/models/news_model_entity.dart';
import 'package:newsapi_sample/repository/top_news_repository.dart';

class TopNewsProvider with ChangeNotifier {
  final TopNewsRepository _repository;

  TopNewsProvider(this._repository);

  List<NewsModelEntity> _newsList = [];
  List<NewsModelEntity> get newsList => _newsList;
  bool _isLoading = false;

  Future<void> fetchTopHeadlines(int page, int pageSize) async {
    try {
      _newsList = await _repository.fetchTopHeadlines(page, pageSize);
    } catch (e) {
      debugPrint("Error fetching fetchAllNews: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
