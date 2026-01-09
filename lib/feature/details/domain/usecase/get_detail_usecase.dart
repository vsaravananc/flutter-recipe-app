import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/details/domain/entities/detail_entite.dart';
import 'package:recipe/feature/details/domain/repo/detail_repo.dart';

typedef GetFoodDetail = Either<FailerHandler, SuccessHandler<DetailEntite>>;

class GetDetailUsecase {
  final GetFoodDetailRepo getFoodDetailRepo;
  const GetDetailUsecase({required this.getFoodDetailRepo});
  Future<GetFoodDetail> getfoodDetail({required String id}) async {
    return getFoodDetailRepo.getFoodDetail(id: id);
  }
}
