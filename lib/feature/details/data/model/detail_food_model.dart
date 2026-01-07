import 'package:recipe/feature/details/domain/entities/detail_entite.dart';

class DetailFoodModel extends DetailEntite {
  const DetailFoodModel({
    required super.mealId,
    required super.mealName,
    required super.mealAlternate,
    required super.mealArea,
    required super.mealInstruction,
    required super.mealThumbImage,
    required super.mealTag,
    required super.mealCookingVideo,
    required super.mealIntegrationCollection,
    required super.mealMeasureCollection,
    required super.mealSource,
    required super.mealSourceImage,
  });
  
}
