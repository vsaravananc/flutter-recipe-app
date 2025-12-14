
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';

class SelectAreaUseCase {
  final UserSugestionRepo userSugestionRepo;
  SelectAreaUseCase({required this.userSugestionRepo});
  Future<void> selectArea(
    AreaEntities area,
  ) async {
    return await userSugestionRepo.selectedArea(area);
  }
}
