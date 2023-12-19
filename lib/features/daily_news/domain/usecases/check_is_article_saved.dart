import 'package:news_clean_app/core/usecase/usecase.dart';
import 'package:news_clean_app/features/daily_news/domain/repository/article_repository.dart';

class CheckIsArticleSavedUseCase implements UseCase<bool?, String> {
  final ArticleRepository _articleRepository;
  CheckIsArticleSavedUseCase(this._articleRepository);
  @override
  Future<bool?> call({String? params}) {
    return _articleRepository.checkIsArticleSaved(params!);
  }
}
