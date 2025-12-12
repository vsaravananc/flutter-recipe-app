import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';

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
  Future<Either<FailerHandler, SuccessHandler<bool>>> selectedArea(
    AreaEntities area,
  ) async {
    return await dataSourcesRepo.selectedArea(AreaModel(area: area.area));
  }
}
