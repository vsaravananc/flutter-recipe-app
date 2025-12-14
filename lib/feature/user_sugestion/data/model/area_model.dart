import 'package:recipe/feature/user_sugestion/domain/entities/area_entities.dart';

class AreaModel extends AreaEntities {
  const AreaModel({required super.area});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(area: json['strArea']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strArea'] = area;
    return data;
  }

  Map<String, dynamic> toJsonForLocalDatabase(int millSecond) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strArea'] = area;
    data['inserted_at'] = millSecond;
    return data;
  }

  Map<String, dynamic> addArea() {
    return {"selectedArea": area};
  }
}
