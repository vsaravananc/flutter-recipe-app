import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqlite_api.dart';

class UserTable implements CreateTable {
   @override
    Future<void> createTable(Database db , int version) async {
    await db.execute('''
    CREATE TABLE user (
     id INTEGER PRIMARY KEY CHECK (id = 1),
     uuid TEXT,
     name TEXT,
     email TEXT,
     selectedArea TEXT,
     selectedCategory TEXT
    );
    ''');
  }
}
