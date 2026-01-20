import 'package:recipe/feature/search/domain/entities/search_entities.dart';

class SearchModel extends SearchRecipeEntities {
  const SearchModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory SearchModel.fromJson(Map<String,dynamic> json){
    return SearchModel(
      id: json['idMeal'].toString(),
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
    );
  }
}
