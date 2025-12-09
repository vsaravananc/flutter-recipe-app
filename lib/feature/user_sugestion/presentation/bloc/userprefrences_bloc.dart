import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/area_list_use_case.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/category_list_use_case.dart';

part 'userprefrences_event.dart';
part 'userprefrences_state.dart';

class UserprefrencesBloc
    extends Bloc<UserprefrencesEvent, UserprefrencesState> {
  final AreaListUseCase areaListUseCase;
  final CategoryListUseCase categoryListUseCase;
  UserprefrencesBloc({
    required this.areaListUseCase,
    required this.categoryListUseCase,
  }) : super(UserprefrencesInitial()) {
    on<UserprefrencesGetData>((event, emit) async {
      emit(UserprefrencesLoading());
      
      final areaResluts = await areaListUseCase.call();
      final categoryResluts = await categoryListUseCase.call();

      final List<AreaEntities> areas = areaResluts.fold(
        (failer) => <AreaEntities>[],
        (success) => success.data,
      );

      final List<CategoryEntities> categories = categoryResluts.fold(
        (failer) => <CategoryEntities>[],
        (success) => success.data,
      );

      if (areas.isEmpty || categories.isEmpty) {
        emit(UserprefrencesError());
      } else {
        emit(UserprefrencesLoaded(areas: areas, categories: categories));
      }
    });
  }
}
