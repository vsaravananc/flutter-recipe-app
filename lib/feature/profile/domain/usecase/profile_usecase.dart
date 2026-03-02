import 'package:recipe/feature/profile/domain/repo/profile_rep.dart';

class ProfileUsecase {
  final ProfileRepository repository;
  ProfileUsecase({required this.repository});

  Future<void> updateProfileImage(String image) async {
    await repository.updateProfileImage(image);
  }
}