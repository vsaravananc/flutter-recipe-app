import 'package:recipe/feature/profile/data/data_source/profile_data_source_repo.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDataSourceRepoimpl extends ProfileDataSourceRepository {
  final Database database;
  ProfileDataSourceRepoimpl({required this.database});

  @override
  Future<void> updateProfileImage(String image) async{
    try {
      // await database.update(
      //   'profile',
      //   {'image': image},
      //   where: 'id = ?',
      //   whereArgs: [1],
      // );
    } catch (e) {
      throw Exception('Failed to update profile image: $e');
    }
  }
}