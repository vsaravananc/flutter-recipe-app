part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class GetRecipeEvent extends RecipeEvent {
  final String categoryName;
  const GetRecipeEvent({required this.categoryName});

  @override
  List<Object> get props => [categoryName];
}
