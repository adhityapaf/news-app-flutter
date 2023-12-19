import 'package:equatable/equatable.dart';
import 'package:news_clean_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;
  final bool? isArticleAlreadySaved;

  const LocalArticlesState({this.articles, this.isArticleAlreadySaved});

  @override
  List<Object?> get props => [articles!, isArticleAlreadySaved];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone(
      {List<ArticleEntity>? articles, bool isArticleAlreadySaved = false})
      : super(articles: articles, isArticleAlreadySaved: isArticleAlreadySaved);
}
