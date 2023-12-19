import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_app/features/daily_news/domain/usecases/check_is_article_saved.dart';
import 'package:news_clean_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_clean_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_clean_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final CheckIsArticleSavedUseCase _checkIsArticleSavedUseCase;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
    this._checkIsArticleSavedUseCase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
    on<CheckIsArticleIsSaved>(onCheckIsArticleSaved);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles: articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles: articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles: articles, isArticleAlreadySaved: true));
  }

  void onCheckIsArticleSaved(
      CheckIsArticleIsSaved event, Emitter<LocalArticlesState> emit) async {
    bool isSaved = false;
    try {
      isSaved = await _checkIsArticleSavedUseCase(
              params: event.article?.title ?? '-') ??
          false;
      log('is article saved: $isSaved');
    } catch (e) {
      log('DatabaseError: $e');
    }
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles: articles, isArticleAlreadySaved: isSaved));
  }
}
