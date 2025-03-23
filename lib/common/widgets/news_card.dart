import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapi_sample/common/widgets/common.dart';
import 'package:newsapi_sample/models/news_model_entity.dart';

import '../../screens/detail_screen.dart';
import 'custom_text_widget.dart';

class NewsCard extends StatefulWidget {
  final NewsModelEntity news;

  const NewsCard({super.key, required this.news});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Card(
        elevation: 0.3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                DetailScreen(url: widget.news.url ?? ""),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: widget.news.title ?? "No Title",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomTextWidget(
                          text: widget.news.author ?? "Unknown Author",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextWidget(
                        text: Common.formatTimeAgo(widget.news.publishedAt),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.news.urlToImage ?? '',
                  placeholder:
                      (context, url) => Image.asset(
                        'assets/images/img_place.png',
                        width: 140,
                        height: 105,
                        fit: BoxFit.cover,
                      ),
                  errorWidget:
                      (context, url, error) => Image.asset(
                        'assets/images/img_place.png',
                        width: 140,
                        height: 105,
                        fit: BoxFit.cover,
                      ),
                  width: 140,
                  height: 105,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
