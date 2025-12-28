import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/domain/entities/home_recipe_entities.dart';
import 'package:recipe/feature/home/domain/repo/home_repo.dart';

class HomeRecipeUseCase {
  final HomeRepo repo;
  const HomeRecipeUseCase({required this.repo});

  Future<Either<FailerHandler, SuccessHandler<List<HomeRecipeEntities>>>>
  getRecipe(String category) async => await repo.fetchRecipeData(category);
}
