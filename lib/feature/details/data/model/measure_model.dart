import 'package:recipe/feature/details/domain/entities/detail_entite.dart';

class MeasureModel extends MealMeasure {
  const MeasureModel({required super.measure});

  factory MeasureModel.fromJson(Map<String, dynamic> json) {
    return json['strMeasure'];
  }
  static List<MeasureModel> fromLocalData(
    List<Map<String, dynamic>> localData,
  ) {
    return localData.map((e) => MeasureModel.fromJson(e)).toList();
  }
}
