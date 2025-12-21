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
  const HomecategoryLoaded(this.categories);
}

class HomecategoryError extends HomecategoryState {
  final FailerHandler failer;
  const HomecategoryError(this.failer);
}