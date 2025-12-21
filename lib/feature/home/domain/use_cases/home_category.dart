import 'package:dartz/dartz.dart';
import 'package:recipe/feature/home/domain/repo/home_repo.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';

class HomeCategoryUseCase {
  final HomeRepo homeRepo;
  HomeCategoryUseCase({required this.homeRepo});

  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryEntities>>>>
  fetchHomeCategories() {
    return homeRepo.fetchCategoryData();
  }
}
