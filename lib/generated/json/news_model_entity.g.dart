import 'package:newsapi_sample/generated/json/base/json_convert_content.dart';
import 'package:newsapi_sample/models/news_model_entity.dart';

NewsModelEntity $NewsModelEntityFromJson(Map<String, dynamic> json) {
  final NewsModelEntity newsModelEntity = NewsModelEntity();
  final NewsModelSource? source = jsonConvert.convert<NewsModelSource>(
    json['source'],
  );
  if (source != null) {
    newsModelEntity.source = source;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    newsModelEntity.author = author;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    newsModelEntity.title = title;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    newsModelEntity.description = description;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    newsModelEntity.url = url;
  }
  final String? urlToImage = jsonConvert.convert<String>(json['urlToImage']);
  if (urlToImage != null) {
    newsModelEntity.urlToImage = urlToImage;
  }
  final String? publishedAt = jsonConvert.convert<String>(json['publishedAt']);
  if (publishedAt != null) {
    newsModelEntity.publishedAt = publishedAt;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    newsModelEntity.content = content;
  }
  return newsModelEntity;
}

Map<String, dynamic> $NewsModelEntityToJson(NewsModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['source'] = entity.source?.toJson();
  data['author'] = entity.author;
  data['title'] = entity.title;
  data['description'] = entity.description;
  data['url'] = entity.url;
  data['urlToImage'] = entity.urlToImage;
  data['publishedAt'] = entity.publishedAt;
  data['content'] = entity.content;
  return data;
}

extension NewsModelEntityExtension on NewsModelEntity {
  NewsModelEntity copyWith({
    NewsModelSource? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) {
    return NewsModelEntity()
      ..source = source ?? this.source
      ..author = author ?? this.author
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..url = url ?? this.url
      ..urlToImage = urlToImage ?? this.urlToImage
      ..publishedAt = publishedAt ?? this.publishedAt
      ..content = content ?? this.content;
  }
}

NewsModelSource $NewsModelSourceFromJson(Map<String, dynamic> json) {
  final NewsModelSource newsModelSource = NewsModelSource();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    newsModelSource.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    newsModelSource.name = name;
  }
  return newsModelSource;
}

Map<String, dynamic> $NewsModelSourceToJson(NewsModelSource entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  return data;
}

extension NewsModelSourceExtension on NewsModelSource {
  NewsModelSource copyWith({String? id, String? name}) {
    return NewsModelSource()
      ..id = id ?? this.id
      ..name = name ?? this.name;
  }
}
