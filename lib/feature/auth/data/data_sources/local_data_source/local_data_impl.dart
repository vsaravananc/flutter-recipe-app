import 'package:recipe/feature/auth/data/data_sources/local_data_source/local_data_repo.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataImpl implements LocalDataRepo {
  final Database database;
  LocalDataImpl({required this.database});
  @override
  Future<void> addUser(UserModel user) async {
    await database.insert(
      "user",
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
