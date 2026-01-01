part of 'homecategory_bloc.dart';

abstract class HomecategoryState extends Equatable {
  const HomecategoryState();
  
  @override
  List<Object> get props => [];

}

class HomecategoryInitial extends HomecategoryState {}

class HomecategoryLoading extends HomecategoryState {}

class HomecategoryLoaded extends HomecategoryState {
  final List<HomeCategoryEntities> categories;
  final HomeCategoryEntities selectedCategories;
  const HomecategoryLoaded(this.categories,this.selectedCategories);

  @override
  List<Object> get props => [categories,selectedCategories];
}

class HomecategoryError extends HomecategoryState {
  final FailerHandler failer;
  const HomecategoryError(this.failer);
}