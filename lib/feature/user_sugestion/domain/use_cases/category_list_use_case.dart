import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';

class CategoryListUseCase {
  final UserSugestionRepo userSugestionRepo;
  const CategoryListUseCase({required this.userSugestionRepo});

  Future<Either<FailerHandler, SuccessHandler<List<CategoryEntities>>>>
  call() async => await userSugestionRepo.getListOfCategory();
}
