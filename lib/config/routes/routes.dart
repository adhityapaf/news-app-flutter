import 'package:flutter/material.dart';
import 'package:news_clean_app/features/daily_news/domain/entities/article.dart';
import 'package:news_clean_app/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_clean_app/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_clean_app/features/daily_news/presentation/pages/saved_article/saved_article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());
      case '/ArticleDetails':
        {
          ArticleEntity? article;
          bool isFromSavedArticle = false;
          if (settings.arguments is List<dynamic>) {
            List<dynamic> list = settings.arguments as List<dynamic>;
            article = list[0] as ArticleEntity;
            isFromSavedArticle = list[1] as bool;
          } else {
            article = settings.arguments as ArticleEntity;
          }
          return _materialRoute(ArticleDetailView(
            article: article,
            isFromSavedArticle: isFromSavedArticle,
          ));
        }
      case '/SavedArticles':
        return _materialRoute(const SavedArticles());
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
