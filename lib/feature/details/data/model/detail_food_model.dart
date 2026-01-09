import 'package:recipe/feature/details/data/model/ingredient_model.dart';
import 'package:recipe/feature/details/data/model/measure_model.dart';
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
  Map<String, dynamic> toFoodDataJson(int insertAt) {
    return {
      'idMeal': mealId,
      'strMeal': mealName,
      'strMealAlternate': mealAlternate,
      'strArea': mealArea,
      'strInstructions': mealInstruction,
      'strMealThumb': mealThumbImage,
      'strTags': mealTag,
      'strYoutube': mealCookingVideo,
      'strSource': mealSource,
      'strImageSource': mealSourceImage,
      'inserted_at': insertAt,
    };
  }

  List<Map<String, dynamic>> toIngredientJson(int insertAt) {
    return mealIntegrationCollection
        .map(
          (e) => {
            "idMeal": mealId,
            "strIngredient": e.integration,
            "inserted_at": insertAt,
          },
        )
        .toList();
  }

  List<Map<String, dynamic>> toMeasureJson(int insertAt) {
    return mealMeasureCollection
        .map(
          (e) => {
            "idMeal": mealId,
            "strMeasure": e.measure,
            "inserted_at": insertAt,
          },
        )
        .toList();
  }

  factory DetailFoodModel.fromJson(Map<String, dynamic> json) {
    return DetailFoodModel(
      mealId: json['idMeal'],
      mealName: json['strMeal'],
      mealAlternate: json['strMealAlternate'],
      mealArea: json['strArea'],
      mealInstruction: json['strInstructions'],
      mealThumbImage: json['strMealThumb'],
      mealTag: json['strTags'],
      mealCookingVideo: json['strYoutube'],
      mealIntegrationCollection: json['ingredient_model'],
      mealMeasureCollection: json['measure_model'],
      mealSource: json['strSource'],
      mealSourceImage: json['strImageSource'],
    );
  }

  factory DetailFoodModel.fromRemoteData(Map<String, dynamic> json) {
    return DetailFoodModel(
      mealId: json['idMeal'] ?? '',
      mealName: json['strMeal'] ?? '',
      mealAlternate: json['strMealAlternate'] ?? "",
      mealArea: json['strArea'] ?? "",
      mealInstruction: json['strInstructions'] ?? "",
      mealThumbImage: json['strMealThumb'] ?? '',
      mealTag: json['strTags'] ?? "",
      mealCookingVideo: json['strYoutube'] ?? "",
      mealIntegrationCollection: _convertToIngredient(json),
      mealMeasureCollection: _converToMeasure(json),
      mealSource: json['strSource'] ?? "",
      mealSourceImage: json['strImageSource'] ?? "",
    );
  }

  static List<IngredientModel> _convertToIngredient(Map<String, dynamic> json) {
    List<IngredientModel> model = [];
    for (int i = 1; i <= 20; i++) {
      final value = json['strIngredient$i'];
      if (value is String && value.isNotEmpty) {
        model.add(IngredientModel.fromJson({"strIngredient": value}));
      }
    }
    return model;
  }

  static List<MeasureModel> _converToMeasure(Map<String, dynamic> json) {
    List<MeasureModel> model = [];
    for (int i = 1; i <= 20; i++) {
      final value = json['strIngredient$i'];
      if (value is String && value.isNotEmpty) {
        model.add(MeasureModel.fromJson({"strMeasure": value}));
      }
    }
    return model;
  }
}