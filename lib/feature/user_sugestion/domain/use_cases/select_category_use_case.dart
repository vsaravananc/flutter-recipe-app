
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';

class SelectCategoryUseCase  {
  final UserSugestionRepo userSugestionRepo;
  SelectCategoryUseCase({required this.userSugestionRepo});
  Future<void> selectCategory(CategoryEntities category) async {
    return await userSugestionRepo.selectedCategory(category);
  }
}