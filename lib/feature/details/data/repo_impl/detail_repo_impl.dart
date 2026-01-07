import 'package:recipe/feature/details/data/data_source/detail_datasource_repo.dart';
import 'package:recipe/feature/details/domain/repo/detail_repo.dart'
    hide GetFoodDetail;

class DetailRepoImpl extends GetFoodDetailRepo {
  
  final DetailDatasourceRepo datasourceRepo;
  DetailRepoImpl({required this.datasourceRepo});

  @override
  Future<GetFoodDetail> getFoodDetail({required String id}) async {
    return await datasourceRepo.getFoodDetail(id: id);
  }
}
