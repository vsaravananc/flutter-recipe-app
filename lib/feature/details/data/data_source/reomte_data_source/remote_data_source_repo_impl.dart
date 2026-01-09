import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/details/data/data_source/reomte_data_source/remote_data_source_repo.dart';
import 'package:recipe/feature/details/data/model/detail_food_model.dart';

class RemoteDataSourceRepoImpl implements RemoteDataSourceRepo {
  final Dio dio;
  RemoteDataSourceRepoImpl({required this.dio});
  @override
  Future<GetFoodDetailRemote> getFoodDetail({required String id}) async {
    try {
      final response = await dio.get(ApiEndpoints.detailView + id);
      if (response.statusCode != 200) {
        return Left(NotValideCodeFailer("Oops! Something went wrong."));
      }
      final DetailFoodModel foodModel = await compute(
        _convertFood,
        response.data as Map<String, dynamic>,
      );
      return Right(SuccessHandlerImpl<DetailFoodModel>(foodModel));
    } on DioException catch (e) {
      debugPrint("DioException ${e.toString()}");
      return Left(
        ServerFailure(
          "Couldn't reach the server. Please check your connection or try again later",
        ),
      );
    } on TypeError catch (e) {
      debugPrint("typeError ${e.toString()}");
      return Left(
        TypeErrorFailer(
          "Unexpected data from server received. Please check your connection or try again later.",
        ),
      );
    } catch (e) {
      debugPrint("catch ${e.toString()}");
      return Left(
        CacheFailure(
          "We’re unable to reach the server right now. Please check your connection or try again later.",
        ),
      );
    }
  }
}

DetailFoodModel _convertFood(Map<String, dynamic> json) {
  return DetailFoodModel.fromRemoteData((json['meals'] as List).first);
}
