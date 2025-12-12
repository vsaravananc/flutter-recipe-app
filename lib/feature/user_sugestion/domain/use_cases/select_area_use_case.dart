import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';

class SelectAreaUseCase {
  final UserSugestionRepo userSugestionRepo;
  SelectAreaUseCase({required this.userSugestionRepo});
  Future<Either<FailerHandler, SuccessHandler>> selectArea(
    AreaEntities area,
  ) async {
    return await userSugestionRepo.selectedArea(area);
  }
}
