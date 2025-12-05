import 'package:recipe/core/database/tables/category_table.dart';
import 'package:recipe/core/database/tables/meal_table.dart';
import 'package:sqflite/sqflite.dart';

class CreateDatabase {
  final CategoryTable categoryTable;
  final MealTable mealTable;
  CreateDatabase({required this.categoryTable, required this.mealTable});
  Database? _database;

  Future<Database> createInstance() async {
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

  Future<void> _onCreate(Database db, int version) async {
    await categoryTable.createTable(db,version);
    await mealTable.createTable(db,version);
  }

  Future<Database> get database async {
    _database ??= await createInstance();
    return _database!;
  }
}
