import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqflite.dart';

class FooddetailTable extends CreateTable {
  @override
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE foodTable (
        idMeal TEXT PRIMARY KEY,
        strMeal TEXT,
        strMealAlternate TEXT,
        strArea TEXT,
        strInstructions TEXT,
        strMealThumb TEXT,
        strTags TEXT,
        strYoutube TEXT,
        strSource TEXT,
        strImageSource TEXT,
        inserted_at INTERGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE ingredientTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idMeal TEXT NOT NULL,
        strIngredient TEXT NOT NULL,
        inserted_at INTERGER NOT NULL,
        FOREIGN KEY (idMeal) REFERENCES foodTable(idMeal) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE measureTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idMeal TEXT NOT NULL,
        strMeasure TEXT NOT NULL,
        inserted_at INTERGER NOT NULL,
        FOREIGN KEY (idMeal) REFERENCES foodTable(idMeal) ON DELETE CASCADE
      );
    ''');
  }
}
