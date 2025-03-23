import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapi_sample/common/app_strings.dart';
import 'package:newsapi_sample/models/news_model_entity.dart';

class ApiService {
  final Dio _dio = Dio();

  ///** GET TOP HEADLINES NEWS HERE**
  Future<List<NewsModelEntity>> fetchTopHeadlines(
    int page,
    int pageSize,
  ) async {
    final url =
        "${AppStrings.baseUrl}/?country=us&page=$page&pageSize=$pageSize&apiKey=${AppStrings.apiKey}";
    debugPrint("fetchTopHeadlines: url: $url");

    try {
      final response = await _dio.get(Uri.parse(url).toString());

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;

        // Check if "articles" exists in the response
        if (jsonData.containsKey('articles')) {
          final List<dynamic> articlesJson = jsonData['articles'];

          // Convert JSON list into List<NewsModelEntity>
          return articlesJson
              .map((json) => NewsModelEntity.fromJson(json))
              .toList();
        }
        return [];
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching news: $e\n$stackTrace");
      throw Exception("Error fetching categories: $e");
    }
  }
}
