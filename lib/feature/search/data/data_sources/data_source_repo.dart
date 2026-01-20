import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/search/data/model/search_model.dart';

typedef SearchResultData =
    Future<Either<FailerHandler, SuccessHandler<List<SearchModel>>>>;

abstract class SearchDataSourceRepo {
  SearchResultData searchRecipe(String recipe);
}
