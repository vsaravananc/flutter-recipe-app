part of 'userprefrences_bloc.dart';

abstract class UserprefrencesEvent extends Equatable {
  const UserprefrencesEvent();
  @override
  List<Object> get props => [];
}

class UserprefrencesGetData extends UserprefrencesEvent {}