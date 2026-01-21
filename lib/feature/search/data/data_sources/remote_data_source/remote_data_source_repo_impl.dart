import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/api/endpoints/api_endpoints.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/search/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/search/data/data_sources/remote_data_source/remote_data_source_repo.dart';
import 'package:recipe/feature/search/data/model/search_model.dart';

class RemoteSearchDataSourceRepoImpl implements RemoteSearchDataSourceRepo {
  final Dio dio;
  const RemoteSearchDataSourceRepoImpl({required this.dio});

  @override
  SearchResultData remoteSearchRecipe(String recipe) async {
    try {
      final response = await dio.get(ApiEndpoints.searchByName + recipe);
      if (response.statusCode == 200 && (response.data["meals"] is List)) {
        List<dynamic> fromApi = response.data['meals'] as List<dynamic>;
        if (fromApi.isEmpty) return Right(SuccessHandlerImpl([]));
        List<SearchModel> converted = await compute(_fromCmpute, fromApi);
        return Right(SuccessHandlerImpl(converted));
      }
      throw Exception();
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

List<SearchModel> _fromCmpute(List<dynamic> response) {
  return response.map((e) {
    Map<String, dynamic> json = Map<String, dynamic>.from(e);
    return SearchModel.fromJson(json);
  }).toList();
}
