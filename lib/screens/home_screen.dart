import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newsapi_sample/common/widgets/news_card.dart';
import 'package:newsapi_sample/models/news_model_entity.dart';
import 'package:newsapi_sample/providers/top_news_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _pageSize = 10;
  final PagingController<int, NewsModelEntity> _pagingController =
      PagingController(firstPageKey: 1);
  bool _isFetching = false; // Prevent duplicate API calls

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchNews); // Handles pagination
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchNews(int pageKey) async {
    if (_isFetching) return; // Prevent duplicate calls
    _isFetching = true;

    try {
      final topNewsProvider = context.read<TopNewsProvider>();
      await topNewsProvider.fetchTopHeadlines(pageKey, _pageSize);
      final freshNews = topNewsProvider.newsList;

      if (pageKey == 1) {
        _pagingController.itemList = freshNews; // Refresh case
      }

      freshNews.length < _pageSize
          ? _pagingController.appendLastPage(freshNews)
          : _pagingController.appendPage(freshNews, pageKey + 1);
    } catch (error) {
      _pagingController.error = error;
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _refreshNews() async {
    _pagingController.refresh();
    await _fetchNews(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshNews, // Refresh logic
            child: PagedListView<int, NewsModelEntity>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<NewsModelEntity>(
                itemBuilder: (context, item, index) => NewsCard(news: item),
                firstPageProgressIndicatorBuilder:
                    (_) => const Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder:
                    (_) => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
