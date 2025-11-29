import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqflite.dart';

class CategoryTable implements CreateTable {
   @override
     Future<void> createTable(Database db) async {
    await db.execute('''
     CREATE TABLE category (
     idCategory INTEGER PRIMARY KEY,
     strCategory TEXT,
     strCategoryThumb TEXT,
     strCategoryDescription TEXT
     );
    ''');
  }
}
