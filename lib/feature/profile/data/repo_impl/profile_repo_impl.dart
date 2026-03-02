import 'package:recipe/feature/profile/data/data_source/profile_data_source_repo.dart';
import 'package:recipe/feature/profile/domain/repo/profile_rep.dart';

class ProfileRepoImpl extends ProfileRepository {

  final ProfileDataSourceRepository dataSourceRepository;

  ProfileRepoImpl({required this.dataSourceRepository});

  @override
  Future<void> updateProfileImage(String image) {
    return dataSourceRepository.updateProfileImage(image);
  }
  
}