import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqlite_api.dart';

class MealTable implements CreateTable {
   @override
    Future<void> createTable(Database db , int version) async {
    await db.execute('''
    CREATE TABLE meal (
      strMeal TEXT NOT NULL,
      strMealThumb TEXT NOT NULL,
      idMeal INTEGER PRIMARY KEY,
      inserted_at INTEGER NOT NULL
    );
    ''');
  }
}
