import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqflite.dart';

class RecipesTable extends CreateTable {
  @override
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
       CREATE TABLE recipe (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        foodtype_id INTEGER NOT NULL,
        strMeal TEXT NOT NULL,
        strMealThumb TEXT NOT NULL,
        idMeal TEXT NOT NULL,
        inserted_at INTEGER NOT NULL,
        FOREIGN KEY (foodtype_id)
            REFERENCES foodtype(id)
            ON DELETE CASCADE
    );
    ''');
  }
}
