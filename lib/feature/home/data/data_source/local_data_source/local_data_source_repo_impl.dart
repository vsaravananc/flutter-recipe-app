import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/home/data/model/home_category_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceHomeRepoImpl implements LocalDataSourceHomeRepo {
  final Database database;
  LocalDataSourceHomeRepoImpl({required this.database});
  @override
  Future<Either<FailerHandler, SuccessHandler<List<HomeCategoryModel>>>>
  fetchCategoryData() async {
    try {
      final timeToDie = DateTime.now()
          .subtract(const Duration(days: 2))
          .millisecondsSinceEpoch;
      final result = await database.query(
        'foodtype',
        where: 'inserted_at >= ?',
        whereArgs: [timeToDie],
      );

      if (result.isEmpty) {
        return Left(LocalDataBaseFailure("Cache expired or empty"));
      } else {
        List<HomeCategoryModel> convertedValue = await compute(
          _mapToModelList,
          result,
        );
        for (HomeCategoryModel i in convertedValue) {
          debugPrint(
            "\u001B[32m HomeCategory local model : ${i.id} : ${i.name} : ${i.imageUrl} \u001B[0m",
          );
        }
        return Right(SuccessHandlerImpl(convertedValue));
      }
    } on TypeError catch (_) {
      return Left(TypeErrorFailer("Data format is incorrect"));
    } catch (e) {
      return Left(CacheFailure("Failed to fetch data from local source"));
    }
  }

  @override
  Future<void> addCategoryData(List<HomeCategoryModel> categories) async {
    final batch = database.batch();
    final int timeToDie = DateTime.now().millisecondsSinceEpoch;
    batch.delete('foodtype');
    for (var category in categories) {
      batch.insert(
        'foodtype',
        category.toJsonLocalDatabase(timeToDie),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}

List<HomeCategoryModel> _mapToModelList(List<Map<String, Object?>> result) {
  return result.map<HomeCategoryModel>((value) {
    Map<String, dynamic> e = value as Map<String, dynamic>;

    return HomeCategoryModel(
      id: e['id'].toString(),
      name: e['strCategory'],
      imageUrl: e['strCategoryThumb'],
      description: e['strCategoryDescription'],
    );
  }).toList();
}
