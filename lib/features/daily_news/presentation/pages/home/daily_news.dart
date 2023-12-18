import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_app/features/daily_news/domain/entities/article.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/primary_app_bar.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/primary_loading.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryAppBar(
          title: 'Daily News',
          isLeadingDisabled: true,
          actions: [_BuildSavedArticles()]),
      body: _BuildBody(),
    );
  }
}

class _BuildSavedArticles extends StatelessWidget {
  const _BuildSavedArticles();

  void onSavedArticlesTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Icon(
          Icons.bookmark,
          color: Colors.black,
        ),
      ),
      onTap: () => onSavedArticlesTapped(context),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    void onArticlePressed(BuildContext context, ArticleEntity article) {
      Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
    }

    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticlesLoading) {
        return const PrimaryLoading();
      }
      if (state is RemoteArticlesError) {
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (state is RemoteArticlesDone) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            return ArticleWidget(
              article: state.articles![index],
              onArticlePressed: (article) => onArticlePressed(context, article),
            );
          },
          itemCount: state.articles!.length,
        );
      }
      return const SizedBox();
    });
  }
}
