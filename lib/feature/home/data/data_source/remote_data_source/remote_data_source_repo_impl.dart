import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo.dart';
import 'package:recipe/feature/home/data/model/home_category_model.dart';
import 'package:recipe/feature/home/data/model/home_recipe_model.dart';

class RemoteDataSourceHomeRepoImpl implements RemoteDataSourceHomeRepo {
  final Dio dio;
  RemoteDataSourceHomeRepoImpl({required this.dio});
  @override
  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryModel>>>>
  fetchCategoryData() async {
    try {
      final response = await dio.get(ApiEndpoints.foodType);
      if (response.statusCode != 200) {
        return Left(NotValideCodeFailer("Oops! Something went wrong."));
      }
      List<HomeCategoryModel> convertedValue = await compute(
        _convertCategoryModel,
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
  Future<Either<FailerHandler, SuccessHandler<List<HomeRecipeModel>>>>
  fetchRecipeData(String category) async {
    try {
      final response = await dio.get(ApiEndpoints.filterByCategory + category);
      if (response.statusCode != 200) {
        return Left(NotValideCodeFailer("Oops! Something went wrong."));
      }
      List<HomeRecipeModel> convertedValue = await compute(
        _convertRecipeModel,
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
      debugPrint("typeError on Recipe : ${e.toString()}");
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

List<HomeCategoryModel> _convertCategoryModel(Map<String, dynamic> data) {
  final List<dynamic> results = data['categories'] ?? [];
  return results.map<HomeCategoryModel>((e) {
    return HomeCategoryModel(
      id: e['idCategory'],
      name: e['strCategory'],
      imageUrl: e['strCategoryThumb'],
      description: e['strCategoryDescription'],
    );
  }).toList();
}

List<HomeRecipeModel> _convertRecipeModel(Map<String, dynamic> json) {
  final List<dynamic> meals = json['meals'];
  return meals
      .map<HomeRecipeModel>((e) => HomeRecipeModel.fromJson(e))
      .toList();
}
