import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';

abstract class UserSugestionRepo {
  Future<Either<FailerHandler, SuccessHandler<List<CategoryEntities>>>>
  getListOfCategory();
  Future<Either<FailerHandler, SuccessHandler<List<AreaEntities>>>>
  getListOfArea();
}
