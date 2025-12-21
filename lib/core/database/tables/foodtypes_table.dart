import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqflite.dart';

class FoodtypesTable extends CreateTable {
  @override
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE foodtype (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        strCategory TEXT NOT NULL,
        strCategoryThumb TEXT,
        strCategoryDescription TEXT,
        inserted_at INTEGER NOT NULL
      );
    ''');
  }
}
