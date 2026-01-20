import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/search/domain/entities/search_entities.dart';

typedef SearchRecipeResult =
    Future<Either<FailerHandler, SuccessHandler<List<SearchRecipeEntities>>>>;

abstract class SearchDomainRepo {
  SearchRecipeResult searchRecipe(String recipe);
}
