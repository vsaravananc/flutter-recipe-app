part of 'userprefrences_bloc.dart';

abstract class UserprefrencesEvent extends Equatable {
  const UserprefrencesEvent();
  @override
  List<Object> get props => [];
}

class UserprefrencesGetData extends UserprefrencesEvent {}

class SelectAreaUserPrefrencesEvent extends UserprefrencesEvent {
  final AreaEntities areaEntities;
  const SelectAreaUserPrefrencesEvent({required this.areaEntities});

  @override
  List<Object> get props => [areaEntities];
}
