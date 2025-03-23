import 'package:newsapi_sample/generated/json/base/json_field.dart';
import 'package:newsapi_sample/generated/json/news_model_entity.g.dart';
import 'dart:convert';
export 'package:newsapi_sample/generated/json/news_model_entity.g.dart';

@JsonSerializable()
class NewsModelEntity {
  NewsModelSource? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsModelEntity();

  factory NewsModelEntity.fromJson(Map<String, dynamic> json) =>
      $NewsModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $NewsModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class NewsModelSource {
  String? id;
  String? name;

  NewsModelSource();

  factory NewsModelSource.fromJson(Map<String, dynamic> json) =>
      $NewsModelSourceFromJson(json);

  Map<String, dynamic> toJson() => $NewsModelSourceToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
