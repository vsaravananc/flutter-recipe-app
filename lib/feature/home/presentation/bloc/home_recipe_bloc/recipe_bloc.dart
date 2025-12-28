import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/feature/home/domain/entities/home_recipe_entities.dart';
import 'package:recipe/feature/home/domain/use_cases/home_recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class HomeRecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final HomeRecipeUseCase recipeUseCase;
  HomeRecipeBloc({required this.recipeUseCase}) : super(RecipeInitial()) {
    on<GetRecipeEvent>((event, emit) async {
      emit(RecipeLoading());
      final result = await recipeUseCase.getRecipe(event.categoryName);
      result.fold(
        (failer) => emit(RecipeError(failer: failer)),
        (success) => emit(RecipeLoaded(recipeList: success.data)),
      );
    });
  }
}
