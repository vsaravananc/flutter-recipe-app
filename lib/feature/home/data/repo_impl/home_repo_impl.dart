import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/data_source/data_source_repo.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';
import 'package:recipe/feature/home/domain/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DataSourceRepo dataSourceRepo;
  HomeRepoImpl({required this.dataSourceRepo});
  @override
  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryEntities>>>>
  fetchCategoryData() async {
    return await dataSourceRepo.fetchCategoryData();
  }
}
