part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final ProfileEntitie profileEntitie;
  const ProfileState({required this.profileEntitie});

  @override
  List<Object?> get props => [profileEntitie];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial()
    : super(
        profileEntitie: const ProfileEntitie(
          image: AppImages.avatar,
          name: null,
        ),
      );
}

final class ProfileUpdated extends ProfileState {
  const ProfileUpdated({required super.profileEntitie});
}
