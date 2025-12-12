import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore firebaseFirestore;

  DataSourcesRepoImpl({required this.dio, required this.firebaseFirestore});
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
      for (AreaModel i in convertedValue) {
        debugPrint("\u001B[32 m category model : ${i.area} \u001B[0m");
      }
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
    try {
      final response = await dio.get(ApiEndpoints.listOfCategory);
      if (response.statusCode != 200) {
        return Left(NotValideCodeFailer("Oops! Something went wrong."));
      }
      List<CategoryModel> convertedValue = await compute(
        _convertCategoryModel,
        response.data as Map<String, dynamic>,
      );
      for (CategoryModel i in convertedValue) {
        debugPrint("\u001B[32 m category model : ${i.category} \u001B[0m");
      }
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
  SelectedArea selectedArea(AreaModel category) async {
    try {
      return Right(SuccessHandlerImpl(true));
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

List<AreaModel> _convertAreaModel(Map<String, dynamic> json) {
  return (json['meals'] as List? ?? [])
      .map((e) => AreaModel.fromJson(e))
      .toList();
}

List<CategoryModel> _convertCategoryModel(Map<String, dynamic> json) {
  return (json['meals'] as List? ?? [])
      .map((e) => CategoryModel.fromJson(e))
      .toList();
}
