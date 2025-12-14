import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';

typedef GetListOfArea =
    Future<Either<FailerHandler, SuccessHandler<List<AreaEntities>>>>;
typedef GetListOfCategory =
    Future<Either<FailerHandler, SuccessHandler<List<CategoryEntities>>>>;
typedef SelectedArea = Future<void>;

abstract class UserSugestionRepo {
  GetListOfCategory getListOfCategory();
  GetListOfArea getListOfArea();
  SelectedArea selectedArea(AreaEntities category);
}
