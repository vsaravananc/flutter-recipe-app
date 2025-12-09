

import 'package:recipe/feature/user_sugestion/domain/entities/category_entities.dart';

class CategoryModel extends CategoryEntities {
 const CategoryModel({required super.category});
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(category: json['strCategory']);
  }
}