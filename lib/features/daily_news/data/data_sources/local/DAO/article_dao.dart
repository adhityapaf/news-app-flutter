import 'package:floor/floor.dart';
import 'package:news_clean_app/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();

  @Query('SELECT EXISTS(SELECT * FROM article WHERE title = :title)')
  Future<bool?> checkIsArticleSaved(String title);
}
