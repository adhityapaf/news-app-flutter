import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_clean_app/features/daily_news/domain/entities/article.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_clean_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_clean_app/features/daily_news/presentation/widgets/primary_app_bar.dart';
import 'package:news_clean_app/injection_container.dart';

class ArticleDetailView extends HookWidget {
  final ArticleEntity? article;
  const ArticleDetailView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<LocalArticleBloc>()..add(CheckIsArticleIsSaved(article!)),
      child: Scaffold(
        appBar: const PrimaryAppBar(),
        body: _BuildBody(article: article),
        floatingActionButton: _BuildFloationgActionButton(article: article),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  final ArticleEntity? article;
  const _BuildBody({this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        _BuildArticleTitleAndDate(article: article),
        _BuildArticleImage(article: article),
        _BuildArticleDescription(article: article),
      ]),
    );
  }
}

class _BuildArticleTitleAndDate extends StatelessWidget {
  final ArticleEntity? article;
  const _BuildArticleTitleAndDate({this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            article?.title ?? '-',
            style: const TextStyle(
              fontFamily: 'Butler',
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),

          // Date time
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                article?.publishedAt ?? '-',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BuildArticleImage extends StatelessWidget {
  final ArticleEntity? article;
  const _BuildArticleImage({this.article});

  @override
  Widget build(BuildContext context) {
    if (article?.urlToImage?.isEmpty ?? true) {
      return Container(
        width: double.maxFinite,
        height: 250,
        color: Colors.grey.shade300,
        margin: const EdgeInsets.only(top: 14),
        child: const Center(
            child: Icon(
          Icons.error,
          color: Colors.black,
        )),
      );
    }
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(article?.urlToImage ?? '-', fit: BoxFit.cover),
    );
  }
}

class _BuildArticleDescription extends StatelessWidget {
  final ArticleEntity? article;
  const _BuildArticleDescription({this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),
      child: Text(
        '${article?.description ?? '-'}\n\n${article?.content ?? '-'}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class _BuildFloationgActionButton extends StatelessWidget {
  final ArticleEntity? article;
  const _BuildFloationgActionButton({this.article});

  void _onFloatingActionButtonTapped(BuildContext context) {
    context.read<LocalArticleBloc>().add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Article saved successfully.',
      ),
      backgroundColor: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalArticleBloc, LocalArticlesState>(
        builder: (context, state) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: state.isArticleAlreadySaved == false
            ? FloatingActionButton(
                onPressed: () => _onFloatingActionButtonTapped(context),
                child: const Icon(
                  Icons.bookmark_add_rounded,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
