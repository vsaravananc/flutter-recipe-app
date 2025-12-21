import 'package:recipe/feature/home/domain/entities/home_category_entities.dart';

class HomeCategoryModel extends HomeCategoryEntities {
  const HomeCategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.description,
  });
  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeCategoryModel(
      id: json['id'],
      name: json['name'] ,
      imageUrl: json['imageUrl'] ,
      description: json['description'] ,
    );
  }

  Map<String, dynamic> toJsonLocalDatabase(
      int millSecondsSinceEpoch
  ) {
    return {
      'id': int.parse(id),
      'strCategory': name,
      'strCategoryThumb': imageUrl,
      'strCategoryDescription': description,
      'inserted_at': millSecondsSinceEpoch,
    };
  }
  
}
