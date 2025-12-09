import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';

abstract class DataSourcesRepo {
  Future<Either<FailerHandler, SuccessHandler<List<AreaModel>>>>
  getListOfArea();
  Future<Either<FailerHandler, SuccessHandler<List<CategoryModel>>>>
  getListOfCategory();
}
