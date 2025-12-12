import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';

typedef GetListOfArea =
    Future<Either<FailerHandler, SuccessHandler<List<AreaModel>>>>;
typedef GetListOfCategory =
    Future<Either<FailerHandler, SuccessHandler<List<CategoryModel>>>>;
typedef SelectedArea = Future<Either<FailerHandler, SuccessHandler<bool>>>;

abstract class DataSourcesRepo {
  GetListOfArea getListOfArea();
  GetListOfCategory getListOfCategory();
  SelectedArea selectedArea(AreaModel category);
}
