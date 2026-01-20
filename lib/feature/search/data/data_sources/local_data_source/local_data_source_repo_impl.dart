import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/search/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/search/data/data_sources/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/search/data/model/search_model.dart';
import 'package:sqflite/sqlite_api.dart';

class LocalSearchDataSourceRepoImpl extends LocalSearchDataSourceRepo {
  final Database database;
  LocalSearchDataSourceRepoImpl({required this.database});
  @override
  SearchResultData localSearchRecipe(String recipe) async {
    try {
      final response = await database.query(
        'recipe',
        where: 'strMeal LIKE ?',
        whereArgs: ['$recipe%'],
      );
      if (response.isEmpty) {
        return Left(CacheFailure("Failed to fetch data from local source"));
      }
      final List<SearchModel> search = await compute(_fromLocal, response);
      return Right(SuccessHandlerImpl(search));
    } on TypeError catch (_) {
      return Left(TypeErrorFailer("Data format is incorrect"));
    } catch (_) {
      return Left(CacheFailure("Failed to fetch data from local source"));
    }
  }
}

List<SearchModel> _fromLocal(List<Map<String, Object?>> response) {
  return response.map((e) {
    Map<String, dynamic> data = Map<String, dynamic>.from(e);
    return SearchModel.fromJson(data);
  }).toList();
}
