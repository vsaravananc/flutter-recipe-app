part of 'userprefrences_bloc.dart';

abstract class UserprefrencesState extends Equatable {
  const UserprefrencesState();

  @override
  List<Object> get props => [];
}

class UserprefrencesInitial extends UserprefrencesState {}

class UserprefrencesLoaded extends UserprefrencesState {
  final List<AreaEntities> areas;
  final List<CategoryEntities> categories;
  const UserprefrencesLoaded({required this.areas, required this.categories});
  @override
  List<Object> get props => [areas, categories];
}

class UserprefrencesError extends UserprefrencesState {}

class UserprefrencesLoading extends UserprefrencesState {}

class SelectedAreaUserPrefrencesState extends UserprefrencesState {
  final AreaEntities area;
  const SelectedAreaUserPrefrencesState({required this.area});
  @override
  List<Object> get props => [area];
}