import 'package:recipe/feature/details/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceRepoImpl implements LocalDataSourceRepo {
  final Database database;
  LocalDataSourceRepoImpl({required this.database});
  @override
  Future<GetFoodDetailLocal> getFoodDetail({required String id}) {
    throw UnimplementedError();
  }
}
