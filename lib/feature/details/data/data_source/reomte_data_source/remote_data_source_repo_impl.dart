import 'package:dio/dio.dart';
import 'package:recipe/feature/details/data/data_source/reomte_data_source/remote_data_source_repo.dart';

class RemoteDataSourceRepoImpl implements RemoteDataSourceRepo {
  final Dio dio;
  RemoteDataSourceRepoImpl({required this.dio});
  @override
  Future<GetFoodDetailRemote> getFoodDetail({required String id}) {
    // TODO: implement getFoodDetail
    throw UnimplementedError();
  }
}
