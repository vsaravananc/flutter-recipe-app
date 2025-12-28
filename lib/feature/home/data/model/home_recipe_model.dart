import 'package:recipe/feature/home/domain/entities/home_recipe_entities.dart';

class HomeRecipeModel extends HomeRecipeEntities {
  const HomeRecipeModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory HomeRecipeModel.fromJson(Map<String, dynamic> json) {
    return HomeRecipeModel(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
    );
  }

  Map<String, dynamic> toJsonLocalDatabse(int insertedAt,int foodId) {
    return {
      "foodtype_id":foodId,
      "strMeal": id,
      "strMealThumb": imageUrl,
      "idMeal": name,
      "inserted_at": insertedAt,
    };
  }
}
