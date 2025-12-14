import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart'
    hide SelectedCategory;

class UserSugestionRepoImpl implements UserSugestionRepo {
  final DataSourcesRepo dataSourcesRepo;

  UserSugestionRepoImpl({required this.dataSourcesRepo});
  @override
  Future<Either<FailerHandler, SuccessHandler<List<AreaEntities>>>>
  getListOfArea() async {
    return await dataSourcesRepo.getListOfArea();
  }

  @override
  Future<Either<FailerHandler, SuccessHandler<List<CategoryEntities>>>>
  getListOfCategory() async {
    return await dataSourcesRepo.getListOfCategory();
  }

  @override
  Future<void> selectedArea(AreaEntities area) async {
    await dataSourcesRepo.selectedArea(AreaModel(area: area.area));
  }

  @override
  SelectedCategory selectedCategory(CategoryEntities category) async {
    await dataSourcesRepo.selectedCategory(
      CategoryModel(category: category.category),
    );
  }
}
