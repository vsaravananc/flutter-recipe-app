import 'package:recipe/feature/details/domain/entities/detail_entite.dart';

class IngredientModel extends MealIntegration {
  const IngredientModel({required super.integration});

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(integration: json['strIngredient']);
  }

  static List<IngredientModel> fromLocalData(
    List<Map<String, dynamic>> localData,
  ) {
    return localData.map((e) => IngredientModel.fromJson(e)).toList();
  }

}
