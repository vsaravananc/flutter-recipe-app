import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';
import 'package:recipe/feature/home/domain/use_cases/home_category.dart';

part 'homecategory_event.dart';
part 'homecategory_state.dart';

class HomecategoryBloc extends Bloc<HomecategoryEvent, HomecategoryState> {
  final HomeCategoryUseCase homeCategoryUseCase;
  HomecategoryBloc({required this.homeCategoryUseCase})
    : super(HomecategoryInitial()) {
    on<FetchHomeCategories>((event, emit) async {
      emit(HomecategoryLoading());
      final result = await homeCategoryUseCase.fetchHomeCategories();
      result.fold(
        (failer) => emit(HomecategoryError(failer)),
        (success) => emit(HomecategoryLoaded(success.data, success.data.first)),
      );
    });
    on<SelectHomeCategori>((event, emit) {
      if (state is HomecategoryLoaded) {
        List<HomeCategoryEntities> data =
            (state as HomecategoryLoaded).categories;
        emit(HomecategoryLoaded(data, event.homeCategoryEntities));
      }
    });
  }
}
