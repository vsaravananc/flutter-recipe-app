import 'package:recipe/core/database/tables/areas_table.dart';
import 'package:recipe/core/database/tables/categorys_table.dart';
import 'package:recipe/core/database/tables/foodtypes_table.dart';
import 'package:recipe/core/database/tables/meal_table.dart';
import 'package:recipe/core/database/tables/recipes_table.dart';
import 'package:recipe/core/database/tables/user_table.dart';
import 'package:sqflite/sqflite.dart';

class CreateDatabase {
  final CategorysTable categorysTable;
  final MealTable mealTable;
  final UserTable userTable;
  final AreasTable areaTable;
  final FoodtypesTable foodtypesTable;
  final RecipesTable recipesTable;
  CreateDatabase({
    required this.categorysTable,
    required this.mealTable,
    required this.userTable,
    required this.areaTable,
    required this.foodtypesTable,
    required this.recipesTable,
  });
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
    await categorysTable.createTable(db, version);
    await mealTable.createTable(db, version);
    await userTable.createTable(db, version);
    await areaTable.createTable(db, version);
    await foodtypesTable.createTable(db, version);
    await recipesTable.createTable(db, version);
  }

  Future<Database> get database async {
    _database ??= await createInstance();
    return _database!;
  }
}
