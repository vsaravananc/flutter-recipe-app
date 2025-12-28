part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<HomeRecipeEntities> recipeList;
  const RecipeLoaded({required this.recipeList});

  @override
  List<Object> get props => recipeList;
}

class RecipeError extends RecipeState {
  final FailerHandler failer;
  const RecipeError({required this.failer});

  
  @override
  List<Object> get props => [failer];
}
