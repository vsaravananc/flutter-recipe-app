part of 'homecategory_bloc.dart';

abstract class HomecategoryEvent extends Equatable {
  const HomecategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeCategories extends HomecategoryEvent {}

class SelectHomeCategori extends HomecategoryEvent {
  final HomeCategoryEntities homeCategoryEntities;
  const SelectHomeCategori({required this.homeCategoryEntities});

  @override
  List<Object> get props => [homeCategoryEntities];
}