part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}


class ProfileImageChanged extends ProfileEvent {
  final String image;
  const ProfileImageChanged(this.image);
  
  @override
  List<Object> get props => [image];
}

class ProfileNameChanged extends ProfileEvent {
  final String name;
  const ProfileNameChanged(this.name);
  
  @override
  List<Object> get props => [name];
}