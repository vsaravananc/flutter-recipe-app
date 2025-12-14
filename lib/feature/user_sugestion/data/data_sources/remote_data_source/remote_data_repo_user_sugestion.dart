import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';

typedef Getlistofarearemote = Either<FailerHandler, SuccessHandler<List<AreaModel>>>;
typedef Getlistofcategoryremote = Either<FailerHandler, SuccessHandler<List<CategoryModel>>>;

abstract class RemoteDataRepoUserSugestion {
  Future<Getlistofarearemote> getListOfArea();
  Future<Getlistofcategoryremote> getListOfCategory();
  Future<void> selectedArea(AreaModel area, String uuid);
  Future<void> selectedCategory(CategoryModel category, String uuid);
}
