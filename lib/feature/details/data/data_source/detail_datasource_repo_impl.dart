import 'package:recipe/feature/details/data/data_source/detail_datasource_repo.dart';
import 'package:recipe/feature/details/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/details/data/data_source/reomte_data_source/remote_data_source_repo.dart';

class DetailDatasourceRepoImpl implements DetailDatasourceRepo {
  final LocalDataSourceRepo localDataSourceRepo;
  final RemoteDataSourceRepo remoteDataSourceRepo;
  DetailDatasourceRepoImpl({
    required this.localDataSourceRepo,
    required this.remoteDataSourceRepo,
  });
  @override
  Future<GetFoodDetail> getFoodDetail({required String id}) {
    throw UnimplementedError();
  }
}
