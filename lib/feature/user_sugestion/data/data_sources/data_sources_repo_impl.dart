import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';

class DataSourcesRepoImpl implements DataSourcesRepo {
  final Dio dio;

  DataSourcesRepoImpl({required this.dio});
  @override
  Future<Either<FailerHandler, SuccessHandler<List<AreaModel>>>>
  getListOfArea() async {
    try {
      final response = await dio.get(ApiEndpoints.listOFArea);
      if (response.statusCode != 200) {
        return Left(NotValideCodeFailer("Oops! Something went wrong."));
      }
      List<AreaModel> convertedValue = await compute(
        _convertAreaModel,
        response.data as Map<String, dynamic>,
      );
      return Right(SuccessHandlerImpl(convertedValue));
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

  @override
  Future<Either<FailerHandler, SuccessHandler<List<CategoryModel>>>>
  getListOfCategory() async {
    return Left(
      ServerFailure(
        "We’re unable to reach the server right now. Please check your connection or try again later.",
      ),
    );
  }
}

List<AreaModel> _convertAreaModel(Map<String, dynamic> json) {
  return (json['meals'] as List? ?? [])
      .map((e) => AreaModel.fromJson(e))
      .toList();
}
