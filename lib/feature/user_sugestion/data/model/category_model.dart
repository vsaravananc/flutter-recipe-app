

import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';

class CategoryModel extends CategoryEntities {
 const CategoryModel({required super.category});
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(category: json['strCategory']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strCategory'] = category;
    return data;
  }

  Map<String, dynamic> toJsonForLocalDatabase(int millSecond) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strCategory'] = category;
    data['inserted_at'] = millSecond;
    return data;
  }
}