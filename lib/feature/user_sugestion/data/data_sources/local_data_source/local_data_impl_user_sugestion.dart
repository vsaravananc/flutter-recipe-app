import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/local_data_source/local_data_repo_user_sugestion.dart';
import 'package:recipe/feature/user_sugestion/data/model/area_model.dart';
import 'package:recipe/feature/user_sugestion/data/model/category_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataImplUserSugestion implements LocalDataRepoUserSugestion {
  final Database database;

  LocalDataImplUserSugestion({required this.database});
  @override
  Future<Getlistofarealocal> getListOfArea() async {
    try {
      final int timetolive = DateTime.now()
          .subtract(const Duration(days: 2))
          .millisecondsSinceEpoch;
      final response = await database.query(
        "area",
        where: "inserted_at >= ?",
        whereArgs: [timetolive],
      );
      if (response.isEmpty) {
        return Left(LocalDataBaseFailure("Cache expired or empty"));
      } else {
        List<AreaModel> convertedValue = response
            .map(AreaModel.fromJson)
            .toList();

        for (AreaModel i in convertedValue) {
          debugPrint("\u001B[32 m area local model : ${i.area} \u001B[0m");
        }

        return Right(SuccessHandlerImpl(convertedValue));
      }
    } on DatabaseException catch (e) {
      return Left(LocalDataBaseFailure(e.toString()));
    } catch (e) {
      return Left(LocalDataBaseFailure("Unexpected error"));
    }
  }

  @override
  Future<void> insertListOfArea(List<AreaModel> listOfAreaModel) async {
    final batch = database.batch();
    final int millSecond = DateTime.now().millisecondsSinceEpoch;

    batch.delete('area');

    for (AreaModel area in listOfAreaModel) {
      batch.insert(
        "area",
        area.toJsonForLocalDatabase(millSecond),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<Getlistofcategorylocal> getListOfCategory() async {
    try {
      final int timetolive = DateTime.now()
          .subtract(const Duration(days: 2))
          .millisecondsSinceEpoch;
      final response = await database.query(
        "category",
        where: "inserted_at >= ?",
        whereArgs: [timetolive],
      );
      if (response.isEmpty) {
        return Left(LocalDataBaseFailure("Cache expired or empty"));
      } else {
        List<CategoryModel> convertedValue = response
            .map(CategoryModel.fromJson)
            .toList();
        for (CategoryModel i in convertedValue) {
          debugPrint(
            "\u001B[32 m categoryModel local model : ${i.category} \u001B[0m",
          );
        }
        return Right(SuccessHandlerImpl(convertedValue));
      }
    } on DatabaseException catch (e) {
      return Left(LocalDataBaseFailure(e.toString()));
    } catch (e) {
      return Left(LocalDataBaseFailure("Unexpected error"));
    }
  }

  @override
  Future<void> insertListOfCategory(
    List<CategoryModel> listOfCategoryModel,
  ) async {
    final batch = database.batch();
    final int milliSec = DateTime.now().millisecondsSinceEpoch;
    for (CategoryModel model in listOfCategoryModel) {
      batch.insert(
        "category",
        model.toJsonForLocalDatabase(milliSec),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<String> selectedArea(AreaModel area) async {
    await database.update(
      'user',
      area.addArea(),
      where: 'id = ?',
      whereArgs: [1],
    );
    final result = await database.query('user');
    return result.first['uuid'] as String? ?? "";
  }
}
