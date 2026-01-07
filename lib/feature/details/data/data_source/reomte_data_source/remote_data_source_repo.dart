
import 'package:dartz/dartz.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/details/data/model/detail_food_model.dart';

typedef GetFoodDetailRemote = Either<FailerHandler,SuccessHandler<DetailFoodModel>>;

abstract class RemoteDataSourceRepo {
  Future<GetFoodDetailRemote> getFoodDetail({required String id}); 
}