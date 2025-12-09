
import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';

class AreaModel extends AreaEntities {
  const AreaModel({required super.area});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(area: json['strArea']);
  }
  
}