import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/feature/details/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/details/data/model/detail_food_model.dart';
import 'package:recipe/feature/details/data/model/ingredient_model.dart';
import 'package:recipe/feature/details/data/model/measure_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceRepoImpl implements LocalDataSourceRepo {
  final Database database;
  LocalDataSourceRepoImpl({required this.database});
  @override
  Future<GetFoodDetailLocal> getFoodDetail({required String id}) async {
    try {
      final int ttd = DateTime.now()
          .subtract(const Duration(days: 2))
          .millisecondsSinceEpoch;

      final foodDetailModel = await database.query(
        'foodTable',
        where: 'idMeal = ? and inserted_at >= ? ',
        whereArgs: [id, ttd],
      );

      final ingredientModel = await database.query(
        'ingredientTable',
        where: 'idMeal = ? and inserted_at >= ? ',
        whereArgs: [id, ttd],
      );

      final measureModel = await database.query(
        "measureTable",
        where: 'idMeal = ? and inserted_at >= ? ',
        whereArgs: [id, ttd],
      );

      if (foodDetailModel.isEmpty ||
          ingredientModel.isEmpty ||
          measureModel.isEmpty) {
        return Left(LocalDataBaseFailure("Cache expired or empty"));
      }

      List<IngredientModel> fromIngredientModel = await compute(
        _convertFromLocal,
        ingredientModel,
      );
      List<MeasureModel> fromMeasureModel = await compute(
        _convertFromLocalMeasure,
        measureModel,
      );

      Map<String, dynamic> foodDetail = foodDetailModel.first;

      foodDetail.addAll({
        "ingredient_model": fromIngredientModel,
        "measure_model": fromMeasureModel,
      });

      return Right(
        SuccessHandlerImpl(await compute(_convertFromFoodModel, foodDetail)),
      );
    } on TypeError catch (_) {
      return Left(TypeErrorFailer("Data format is incorrect"));
    } catch (e) {
      return Left(CacheFailure("Failed to fetch data from local source"));
    }
  }

  @override
  Future<void> addFoodDetail({required DetailFoodModel foodModel}) async {
    final batch = database.batch();
    final int ttl = DateTime.now().millisecondsSinceEpoch;

    batch.insert(
      'foodTable',
      foodModel.toFoodDataJson(ttl),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    foodModel.toIngredientJson(ttl).forEach((e) {
      batch.insert(
        'ingredientTable',
        e,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    foodModel.toMeasureJson(ttl).forEach((e) {
      batch.insert(
        'measureTable',
        e,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });

    await batch.commit(noResult: true);
  }
}

List<IngredientModel> _convertFromLocal(List<Map<String, dynamic>> json) {
  return IngredientModel.fromLocalData(json);
}

List<MeasureModel> _convertFromLocalMeasure(
  List<Map<String, dynamic>> measureModel,
) {
  return MeasureModel.fromLocalData(measureModel);
}

DetailFoodModel _convertFromFoodModel(Map<String, dynamic> json) {
  return DetailFoodModel.fromJson(json);
}
