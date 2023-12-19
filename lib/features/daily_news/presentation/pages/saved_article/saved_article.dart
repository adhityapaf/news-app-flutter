import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_clean_app/features/daily_news/domain/entities/article.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/primary_app_bar.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/primary_loading.dart';
import 'package:news_clean_app/injection_container.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: const Scaffold(
        appBar: PrimaryAppBar(title: 'Saved Articles'),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalArticleBloc, LocalArticlesState>(
        builder: (context, state) {
      if (state is LocalArticlesLoading) {
        return const PrimaryLoading();
      } else if (state is LocalArticlesDone) {
        return _BuildArticleList(state.articles ?? []);
      }
      return const SizedBox();
    });
  }
}

class _BuildArticleList extends StatelessWidget {
  final List<ArticleEntity> articles;
  const _BuildArticleList(this.articles);

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const Center(
        child: Text(
          'NO SAVED ARTICLES',
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    void onRemoveArticle(BuildContext context, ArticleEntity article) {
      BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
    }

    void onArticlePressed(BuildContext context, ArticleEntity article) {
      Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => onRemoveArticle(context, article),
          onArticlePressed: (article) => onArticlePressed(context, article),
        );
      },
      itemCount: articles.length,
    );
  }
}
