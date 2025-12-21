import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';

abstract class HomeRepo {
  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryEntities>>>>
  fetchCategoryData();
}
