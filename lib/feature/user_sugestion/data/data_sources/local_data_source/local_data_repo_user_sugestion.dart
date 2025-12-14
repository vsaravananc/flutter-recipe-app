
import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';

typedef Getlistofarealocal = Either<FailerHandler, SuccessHandler<List<AreaModel>>>;
typedef Getlistofcategorylocal = Either<FailerHandler, SuccessHandler<List<CategoryModel>>>;

abstract class LocalDataRepoUserSugestion {
  Future<Getlistofarealocal> getListOfArea();
  Future<Getlistofcategorylocal> getListOfCategory();
  Future<void> insertListOfArea(List<AreaModel> listOfAreaModel);
  Future<void> insertListOfCategory(List<CategoryModel> listOfCategoryModel);
  Future<String> selectedArea(AreaModel area);

}