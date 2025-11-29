import 'package:recipe/core/database/tables/category_table.dart';
import 'package:recipe/core/database/tables/meal_table.dart';
import 'package:sqflite/sqflite.dart';

class CreateDatabase {
  static Database? _database;

  static Future<Database> createInstance() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/recipe.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await CategoryTable().createTable(db);
    await MealTable().createTable(db);
  }

  static Future<Database> get database async {
    _database ??= await createInstance();
    return _database!;
  }
}
