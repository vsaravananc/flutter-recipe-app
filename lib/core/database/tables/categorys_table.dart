import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqflite.dart';

class CategorysTable implements CreateTable {
  @override
  Future<void> createTable(Database db, int verison) async {
    await db.execute('''
     CREATE TABLE category (
     idCategory INTEGER PRIMARY KEY AUTOINCREMENT,
     strCategory TEXT NOT NULL UNIQUE,
     inserted_at INTEGER NOT NULL
     );
    ''');
  }
}
