import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/details/domain/entities/detail_entite.dart';

typedef GetFoodDetail = Either<FailerHandler, SuccessHandler<DetailEntite>>;

class GetDetailUsecase {
  Future<GetFoodDetail> getfoodDetail({required String id}) async {
    throw UnimplementedError();
  }
}
