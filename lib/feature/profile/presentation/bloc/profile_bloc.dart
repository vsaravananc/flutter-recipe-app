import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe/core/images/app_images.dart';
import 'package:recipe/feature/profile/domain/entities/profile_entitie.dart';
import 'package:recipe/feature/profile/domain/usecase/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase usecase;
  ProfileBloc({required this.usecase}) : super(const ProfileInitial()) {
    on<ProfileImageChanged>((event, emit) async{
     await usecase.updateProfileImage(event.image);
      emit(
        ProfileUpdated(
          profileEntitie: state.profileEntitie.copyWith(image: event.image),
        ),
      );
    });
  }
}
