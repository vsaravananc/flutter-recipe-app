import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/model/home_category_model.dart';
import 'package:recipe/feature/home/data/model/home_recipe_model.dart';

abstract class RemoteDataSourceHomeRepo {
  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryModel>>>>
  fetchCategoryData();

  Future<Either<FailerHandler, SuccessHandler<List<HomeRecipeModel>>>>
  fetchRecipeData(String category);
}
