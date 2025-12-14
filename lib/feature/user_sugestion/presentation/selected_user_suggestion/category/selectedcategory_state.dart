part of 'selectedcategory_cubit.dart';

abstract class SelectedcategoryState extends Equatable {
  final CategoryEntities? categoryEntities;
  const SelectedcategoryState(this.categoryEntities);

  @override
  List<Object?> get props => [categoryEntities];
}

class SelectedcategoryInitial extends SelectedcategoryState {
 const SelectedcategoryInitial(super.categoryEntities);
}

class SelectedCategoryState extends SelectedcategoryState {
  const SelectedCategoryState(super.categoryEntities);
}

