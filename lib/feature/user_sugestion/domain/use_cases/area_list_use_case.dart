import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';

class AreaListUseCase {
  final UserSugestionRepo userSugestionRepo;
  const AreaListUseCase({required this.userSugestionRepo});

  Future<Either<FailerHandler, SuccessHandler<List<AreaEntities>>>>
  call() async => await userSugestionRepo.getListOfArea();
}
