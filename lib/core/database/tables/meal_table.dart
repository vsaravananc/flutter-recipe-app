import 'package:recipe/core/database/repo/repo_table.dart';
import 'package:sqflite/sqlite_api.dart';

class MealTable implements CreateTable {
   @override
    Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE meal (
    idMeal INTEGER PRIMARY KEY,
    strMeal TEXT,
    strMealAlternate TEXT,
    strCategory TEXT,
    strArea TEXT,
    strInstructions TEXT,
    strMealThumb TEXT,
    strTags TEXT,
    strYoutube TEXT,
  
    strIngredient1 TEXT,
    strIngredient2 TEXT,
    strIngredient3 TEXT,
    strIngredient4 TEXT,
    strIngredient5 TEXT,
    strIngredient6 TEXT,
    strIngredient7 TEXT,
    strIngredient8 TEXT,
    strIngredient9 TEXT,
    strIngredient10 TEXT,
    strIngredient11 TEXT,
    strIngredient12 TEXT,
    strIngredient13 TEXT,
    strIngredient14 TEXT,
    strIngredient15 TEXT,
    strIngredient16 TEXT,
    strIngredient17 TEXT,
    strIngredient18 TEXT,
    strIngredient19 TEXT,
    strIngredient20 TEXT,
  
    strMeasure1 TEXT,
    strMeasure2 TEXT,
    strMeasure3 TEXT,
    strMeasure4 TEXT,
    strMeasure5 TEXT,
    strMeasure6 TEXT,
    strMeasure7 TEXT,
    strMeasure8 TEXT,
    strMeasure9 TEXT,
    strMeasure10 TEXT,
    strMeasure11 TEXT,
    strMeasure12 TEXT,
    strMeasure13 TEXT,
    strMeasure14 TEXT,
    strMeasure15 TEXT,
    strMeasure16 TEXT,
    strMeasure17 TEXT,
    strMeasure18 TEXT,
    strMeasure19 TEXT,
    strMeasure20 TEXT,
  
    strSource TEXT,
    strImageSource TEXT,
    strCreativeCommonsConfirmed TEXT,
    dateModified TEXT,
  
    categoryId INTEGER,
    FOREIGN KEY (categoryId) REFERENCES category(idCategory) ON DELETE CASCADE ON UPDATE CASCADE
    );
    ''');
  }
}
