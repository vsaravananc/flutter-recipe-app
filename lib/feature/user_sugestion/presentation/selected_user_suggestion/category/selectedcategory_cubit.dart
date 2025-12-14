import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/select_category_use_case.dart';

part 'selectedcategory_state.dart';

class SelectedcategoryCubit extends Cubit<SelectedcategoryState> {
  final SelectCategoryUseCase selectCategoryUseCase;
  SelectedcategoryCubit({required this.selectCategoryUseCase})
    : super(const SelectedcategoryInitial(null));

  Future<void> selectCategory(CategoryEntities categroyEntities) async {
    emit(SelectedCategoryState(categroyEntities));
    await selectCategoryUseCase.selectCategory(categroyEntities);
  }
}
