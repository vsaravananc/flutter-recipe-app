import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqlite_api.dart';

class UserTable implements CreateTable {
   @override
    Future<void> createTable(Database db , int version) async {
    await db.execute('''
    CREATE TABLE user (
     uid TEXT,
     name TEXT,
     email TEXT,
    );
    ''');
  }
}
