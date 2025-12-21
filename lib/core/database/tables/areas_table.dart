import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqflite.dart';

class AreasTable implements CreateTable {
  @override
  Future<void> createTable(Database db, int version) async {
    await db.execute('''
     CREATE TABLE area (
     idArea INTEGER PRIMARY KEY AUTOINCREMENT,
     strArea TEXT NOT NULL UNIQUE,
     inserted_at INTEGER NOT NULL
     );
     ''');
  }
}
